import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/slicer/three_mf_parser.dart';
import 'package:printcost/domain/slicer/filament_matcher.dart';
import 'package:printcost/domain/slicer/slice_data.dart';

Uint8List fixture(String name) => File('test/fixtures/$name').readAsBytesSync();

Matcher throwsProblem(SliceImportProblem p) =>
    throwsA(isA<SliceImportException>().having((e) => e.problem, 'problem', p));

void main() {
  group('parseThreeMf (sample Bambu Studio file)', () {
    final info = parseThreeMf(fixture('sample_bambu_sliced.3mf'));

    test('reads slicer version and skips plates that were not sliced', () {
      expect(info.slicerVersion, '01.10.01.50');
      expect(info.plates.map((p) => p.index), [1, 2]);
    });

    test('plate 1: time, total weight, name and two AMS filaments', () {
      final p = info.plates.first;
      expect(p.name, 'Vaso bicolor');
      expect(p.printSeconds, 8122);
      expect(p.totalWeightMg, 45310);
      expect(p.filaments, hasLength(2));
      expect(p.filaments[0].slot, 1);
      expect(p.filaments[0].material, 'PLA');
      expect(p.filaments[0].colorHex, '#FFFFFF');
      expect(p.filaments[0].weightMg, 35880);
      // 8-digit RGBA color is reduced to RGB.
      expect(p.filaments[1].colorHex, '#000000');
      expect(p.filaments[1].weightMg, 9430);
    });

    test('plate 2 without a name', () {
      final p = info.plates[1];
      expect(p.name, isNull);
      expect(p.printSeconds, 1500);
      expect(p.filaments.single.material, 'PETG');
      expect(p.filaments.single.weightMg, 4200);
    });
  });

  test('file with only total weight: no per-filament weight, no time', () {
    final p = parseThreeMf(fixture('sample_total_weight_only.3mf'))
        .plates
        .single;
    expect(p.filaments, isEmpty);
    expect(p.totalWeightMg, 20500);
    expect(p.hasTime, isFalse);
    expect(p.hasWeight, isTrue);
  });

  test('3mf that was never sliced', () {
    expect(
      () => parseThreeMf(fixture('sample_unsliced.3mf')),
      throwsProblem(SliceImportProblem.noSliceInfo),
    );
  });

  test('zip that is not a 3mf, and random bytes', () {
    expect(
      () => parseThreeMf(fixture('not_a_3mf.zip')),
      throwsProblem(SliceImportProblem.notA3mf),
    );
    expect(
      () => parseThreeMf(Uint8List.fromList(List.filled(64, 7))),
      throwsProblem(SliceImportProblem.notA3mf),
    );
  });

  group('real files in test/fixtures/real', () {
    final dir = Directory('test/fixtures/real');
    final files = dir.existsSync()
        ? dir
              .listSync()
              .whereType<File>()
              .where((f) => f.path.toLowerCase().endsWith('.3mf'))
              .toList()
        : <File>[];
    test(
      'has real files',
      () {},
      skip: files.isEmpty
          ? 'Nenhum .3mf real em test/fixtures/real — adicione um para validar'
          : false,
    );
    for (final f in files) {
      test(f.uri.pathSegments.last, () {
        final info = parseThreeMf(f.readAsBytesSync());
        expect(info.plates, isNotEmpty);
        for (final p in info.plates) {
          expect(p.hasWeight, isTrue, reason: 'plate ${p.index} weight');
          expect(p.hasTime, isTrue, reason: 'plate ${p.index} time');
        }
      });
    }
  });

  group('matchFilament', () {
    const candidates = [
      FilamentCandidate(id: 1, material: 'PLA', colorArgb: 0xFFFFFFFF),
      FilamentCandidate(id: 2, material: 'PLA', colorArgb: 0xFF101010),
      FilamentCandidate(id: 3, material: 'PETG', colorArgb: 0xFF1976D2),
      FilamentCandidate(id: 4, material: 'PLA Silk'),
    ];

    test('same material, closest color', () {
      expect(
        matchFilament(
          material: 'PLA',
          colorHex: '#000000',
          candidates: candidates,
        ),
        2,
      );
      expect(
        matchFilament(
          material: 'PLA',
          colorHex: '#F0F0F0',
          candidates: candidates,
        ),
        1,
      );
      expect(
        matchFilament(
          material: 'PETG',
          colorHex: '#FF0000',
          candidates: candidates,
        ),
        3,
      );
    });

    test('material variants match ("PLA Basic" -> PLA)', () {
      expect(
        matchFilament(
          material: 'PLA Basic',
          colorHex: '#FFFFFF',
          candidates: candidates,
        ),
        1,
      );
    });

    test('no match when no filament of that material is registered', () {
      expect(
        matchFilament(
          material: 'TPU',
          colorHex: '#FFFFFF',
          candidates: candidates,
        ),
        isNull,
      );
      expect(
        matchFilament(material: null, colorHex: null, candidates: candidates),
        isNull,
      );
    });
  });
}
