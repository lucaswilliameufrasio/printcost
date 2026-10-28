/// A registered filament as seen by the matcher.
class FilamentCandidate {
  const FilamentCandidate({
    required this.id,
    required this.material,
    this.colorArgb,
  });
  final int id;
  final String material;
  final int? colorArgb;
}

/// Picks the registered filament that best matches a sliced filament:
/// same material (case-insensitive; "PLA Basic" matches "PLA") and the
/// closest color. Returns null when no filament has the same material, so the
/// user chooses manually instead of getting a wrong price.
int? matchFilament({
  required String? material,
  required String? colorHex,
  required List<FilamentCandidate> candidates,
}) {
  if (material == null || candidates.isEmpty) return null;
  final wanted = _normalize(material);
  final sameMaterial = candidates.where((c) {
    final have = _normalize(c.material);
    return have == wanted || wanted.startsWith(have) || have.startsWith(wanted);
  }).toList();
  if (sameMaterial.isEmpty) return null;
  final rgb = _parseHex(colorHex);
  if (rgb == null) return sameMaterial.first.id;
  sameMaterial.sort(
    (a, b) =>
        _distance(a.colorArgb, rgb).compareTo(_distance(b.colorArgb, rgb)),
  );
  return sameMaterial.first.id;
}

String _normalize(String s) =>
    s.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

int? _parseHex(String? hex) {
  if (hex == null) return null;
  return int.tryParse(hex.replaceAll('#', ''), radix: 16);
}

/// Squared RGB distance; filaments without color go last.
int _distance(int? argb, int rgb) {
  if (argb == null) return 1 << 30;
  int ch(int v, int shift) => (v >> shift) & 0xFF;
  var d = 0;
  for (final s in [16, 8, 0]) {
    final diff = ch(argb, s) - ch(rgb, s);
    d += diff * diff;
  }
  return d;
}
