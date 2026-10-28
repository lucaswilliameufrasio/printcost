import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/slicer/three_mf_parser.dart';
import '../../domain/slicer/filament_matcher.dart';
import '../../domain/slicer/slice_data.dart';
import '../../l10n/generated/app_localizations.dart';
import '../calculator/calculator_prefill.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';

/// "Importar do arquivo": pick a .3mf, choose a plate, prefill the
/// calculator. Works fully offline, no printer needed.
Future<void> importSliceFile(
  BuildContext context,
  WidgetRef ref, {
  int? printerId,
}) async {
  final l = AppLocalizations.of(context);
  // FileType.any: Android does not know a MIME type for .3mf.
  final file = await FilePicker.pickFile();
  if (file == null || !context.mounted) return;
  if (!file.name.toLowerCase().endsWith('.3mf')) {
    await _error(context, l.importErrWrongExtension);
    return;
  }
  final bytes = await file.xFile.readAsBytes();
  final SliceInfo info;
  try {
    info = await Isolate.run(() => parseThreeMf(bytes));
  } on SliceImportException catch (e) {
    if (context.mounted) {
      await _error(context, switch (e.problem) {
        SliceImportProblem.notA3mf => l.importErrNotA3mf,
        SliceImportProblem.noSliceInfo => l.importErrNoSliceInfo,
        SliceImportProblem.noSlicedPlates => l.importErrNoPlates,
      });
    }
    return;
  }
  if (!context.mounted) return;
  await applySliceInfo(
    context,
    ref,
    info,
    sourceFile: file.name,
    printerId: printerId,
  );
}

/// Shared with the printer module (job finished -> register print).
Future<void> applySliceInfo(
  BuildContext context,
  WidgetRef ref,
  SliceInfo info, {
  required String sourceFile,
  int? printerId,
}) async {
  final l = AppLocalizations.of(context);
  final fmt = Formatters.of(context, ref);
  var plate = info.plates.first;
  if (info.plates.length > 1) {
    final chosen = await showDialog<SlicedPlate>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l.importPickPlate),
        children: [
          for (final p in info.plates)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(p),
              child: ListTile(
                title: Text(p.name ?? l.plateLabel(p.index)),
                subtitle: Text(
                  [
                    if (p.hasTime) fmt.duration(p.printSeconds!),
                    if (p.totalWeightMg != null) fmt.weight(p.totalWeightMg!),
                  ].join(' · '),
                ),
              ),
            ),
        ],
      ),
    );
    if (chosen == null || !context.mounted) return;
    plate = chosen;
  }

  final filaments = await ref
      .read(catalogRepositoryProvider)
      .watchFilaments()
      .first;
  final candidates = [
    for (final f in filaments)
      FilamentCandidate(id: f.id, material: f.material, colorArgb: f.colorArgb),
  ];
  final prefill = <PrefillFilament>[];
  final warnings = <String>[];
  if (plate.filaments.isNotEmpty) {
    for (final f in plate.filaments) {
      prefill.add(
        PrefillFilament(
          weightMg: f.weightMg,
          label: f.label,
          filamentId: matchFilament(
            material: f.material,
            colorHex: f.colorHex,
            candidates: candidates,
          ),
        ),
      );
    }
  } else if ((plate.totalWeightMg ?? 0) > 0) {
    prefill.add(PrefillFilament(weightMg: plate.totalWeightMg!));
    warnings.add(l.importOnlyTotalWeight(fmt.weight(plate.totalWeightMg!)));
  } else {
    warnings.add(l.importMissingWeight);
  }
  if (!plate.hasTime) warnings.add(l.importMissingTime);
  if (prefill.any((p) => p.filamentId == null && p.label != null)) {
    warnings.add(l.importUnmatched);
  }
  if (!context.mounted) return;

  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l.importSummaryTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sourceFile, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            if (plate.hasTime)
              Text(l.importTime(fmt.duration(plate.printSeconds!))),
            for (final f in plate.filaments)
              Text(l.importFilamentLine(f.label, fmt.weight(f.weightMg))),
            for (final w in warnings)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(w)),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l.cancel),
        ),
        FilledButton(
          key: const Key('import.apply'),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l.importApply),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;

  final baseName = sourceFile
      .replaceAll(RegExp(r'\.gcode\.3mf$', caseSensitive: false), '')
      .replaceAll(RegExp(r'\.3mf$', caseSensitive: false), '');
  ref
      .read(calculatorPrefillProvider.notifier)
      .set(
        CalculatorPrefill(
          filaments: prefill,
          printSeconds: plate.printSeconds,
          sourceFile: sourceFile,
          suggestedName: plate.name ?? baseName,
          printerId: printerId,
        ),
      );
  context.go(Routes.calculator);
}

Future<void> _error(BuildContext context, String message) => showDialog<void>(
  context: context,
  builder: (context) => AlertDialog(
    icon: const Icon(Icons.error_outline),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(AppLocalizations.of(context).ok),
      ),
    ],
  ),
);
