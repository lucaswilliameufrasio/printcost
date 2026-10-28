/// Data read from a sliced project file. Units: mg and seconds.
class SlicedFilament {
  const SlicedFilament({
    required this.weightMg,
    this.slot,
    this.material,
    this.colorHex,
  });

  /// Filament/AMS slot number as written by the slicer (1-based).
  final int? slot;
  final String? material;

  /// `#RRGGBB` (alpha dropped) when known.
  final String? colorHex;
  final int weightMg;

  String get label => [material, colorHex].whereType<String>().join(' ').trim();
}

class SlicedPlate {
  const SlicedPlate({
    required this.index,
    required this.filaments,
    this.name,
    this.printSeconds,
    this.totalWeightMg,
  });

  final int index;
  final String? name;

  /// Estimated print time; null when the file has no estimate.
  final int? printSeconds;
  final int? totalWeightMg;
  final List<SlicedFilament> filaments;

  bool get hasWeight =>
      filaments.any((f) => f.weightMg > 0) || (totalWeightMg ?? 0) > 0;
  bool get hasTime => printSeconds != null && printSeconds! > 0;
}

class SliceInfo {
  const SliceInfo({required this.plates, this.slicerVersion});
  final List<SlicedPlate> plates;
  final String? slicerVersion;
}

enum SliceImportProblem {
  /// Not a ZIP/3MF at all.
  notA3mf,

  /// A 3MF without Metadata/slice_info.config (e.g. never sliced, or
  /// exported by another program).
  noSliceInfo,

  /// slice_info.config exists but has no plate with weight or time.
  noSlicedPlates,
}

class SliceImportException implements Exception {
  const SliceImportException(this.problem);
  final SliceImportProblem problem;

  @override
  String toString() => 'SliceImportException(${problem.name})';
}
