import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

import '../../core/format/scaled_decimal.dart';
import '../../domain/slicer/slice_data.dart';

const sliceInfoPath = 'Metadata/slice_info.config';
const modelSettingsPath = 'Metadata/model_settings.config';

/// Reads weight per filament and print time from a Bambu Studio (or
/// compatible, e.g. OrcaSlicer) `.3mf` / `.gcode.3mf`.
///
/// Format (inside the ZIP, `Metadata/slice_info.config`):
/// ```xml
/// <config>
///   <header><header_item key="X-BBL-Client-Version" value="01.10.01.50"/></header>
///   <plate>
///     <metadata key="index" value="1"/>
///     <metadata key="prediction" value="5025"/>   <!-- seconds -->
///     <metadata key="weight" value="12.44"/>      <!-- grams -->
///     <filament id="1" type="PLA" color="#FFFFFFFF" used_m="4.17" used_g="12.44"/>
///   </plate>
/// </config>
/// ```
/// Pure function: bytes in, data out. Throws [SliceImportException].
SliceInfo parseThreeMf(Uint8List bytes) {
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } on Object {
    throw const SliceImportException(SliceImportProblem.notA3mf);
  }
  if (archive.findFile('[Content_Types].xml') == null &&
      archive.findFile('3D/3dmodel.model') == null &&
      archive.findFile(sliceInfoPath) == null) {
    throw const SliceImportException(SliceImportProblem.notA3mf);
  }
  final sliceFile = archive.findFile(sliceInfoPath);
  if (sliceFile == null) {
    throw const SliceImportException(SliceImportProblem.noSliceInfo);
  }

  final XmlDocument doc;
  try {
    doc = XmlDocument.parse(
      utf8.decode(sliceFile.content, allowMalformed: true),
    );
  } on XmlException {
    throw const SliceImportException(SliceImportProblem.noSliceInfo);
  }

  final plateNames = _plateNames(archive);
  String? version;
  for (final h in doc.findAllElements('header_item')) {
    if (h.getAttribute('key') == 'X-BBL-Client-Version') {
      version = h.getAttribute('value');
    }
  }

  final plates = <SlicedPlate>[];
  for (final (i, plate) in doc.findAllElements('plate').indexed) {
    final meta = <String, String>{
      for (final m in plate.findElements('metadata'))
        ?m.getAttribute('key'): m.getAttribute('value') ?? '',
    };
    final index = int.tryParse(meta['index'] ?? '') ?? i + 1;
    final filaments = <SlicedFilament>[
      for (final f in plate.findElements('filament'))
        SlicedFilament(
          slot: int.tryParse(f.getAttribute('id') ?? ''),
          material: _nonEmpty(f.getAttribute('type')),
          colorHex: _normalizeColor(f.getAttribute('color')),
          weightMg: _grams(f.getAttribute('used_g')) ?? 0,
        ),
    ].where((f) => f.weightMg > 0).toList();
    final seconds = parseScaled(
      meta['prediction'] ?? '',
      scale: 0,
      decimalSeparator: '.',
    );
    final p = SlicedPlate(
      index: index,
      name: plateNames[index],
      printSeconds: seconds,
      totalWeightMg: _grams(meta['weight']),
      filaments: filaments,
    );
    if (p.hasWeight || p.hasTime) plates.add(p);
  }
  if (plates.isEmpty) {
    throw const SliceImportException(SliceImportProblem.noSlicedPlates);
  }
  return SliceInfo(plates: plates, slicerVersion: version);
}

int? _grams(String? value) => value == null
    ? null
    : parseScaled(value, scale: Scales.grams, decimalSeparator: '.');

String? _nonEmpty(String? s) => s == null || s.trim().isEmpty ? null : s.trim();

/// `#FFFFFFFF` / `#ffffff` / `FFFFFF` -> `#FFFFFF`.
String? _normalizeColor(String? c) {
  if (c == null) return null;
  final hex = c.replaceAll('#', '').trim().toUpperCase();
  if (!RegExp(r'^[0-9A-F]{6}([0-9A-F]{2})?$').hasMatch(hex)) return null;
  return '#${hex.substring(0, 6)}';
}

/// Optional plate names from model_settings.config.
Map<int, String> _plateNames(Archive archive) {
  final file = archive.findFile(modelSettingsPath);
  if (file == null) return const {};
  try {
    final doc = XmlDocument.parse(
      utf8.decode(file.content, allowMalformed: true),
    );
    final names = <int, String>{};
    for (final plate in doc.findAllElements('plate')) {
      int? id;
      String? name;
      for (final m in plate.findElements('metadata')) {
        switch (m.getAttribute('key')) {
          case 'plater_id':
            id = int.tryParse(m.getAttribute('value') ?? '');
          case 'plater_name':
            name = _nonEmpty(m.getAttribute('value'));
        }
      }
      if (id != null && name != null) names[id] = name;
    }
    return names;
  } on XmlException {
    return const {};
  }
}
