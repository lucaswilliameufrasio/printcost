/// Exact rational number backed by [BigInt].
///
/// Used by the pricing engine so that money is never represented as a
/// `double`. Every intermediate step is exact; rounding happens only when a
/// value is converted back to integer cents with [roundHalfUp].
class Ratio implements Comparable<Ratio> {
  factory Ratio(BigInt numerator, [BigInt? denominator]) {
    var den = denominator ?? BigInt.one;
    if (den == BigInt.zero) {
      throw ArgumentError.value(denominator, 'denominator', 'must not be zero');
    }
    var num = numerator;
    if (den.isNegative) {
      num = -num;
      den = -den;
    }
    final gcd = num.gcd(den);
    if (gcd > BigInt.one) {
      num = num ~/ gcd;
      den = den ~/ gcd;
    }
    return Ratio._(num, den);
  }

  const Ratio._(this.numerator, this.denominator);

  factory Ratio.of(int numerator, [int denominator = 1]) =>
      Ratio(BigInt.from(numerator), BigInt.from(denominator));

  static final Ratio zero = Ratio.of(0);
  static final Ratio one = Ratio.of(1);

  final BigInt numerator;
  final BigInt denominator;

  Ratio operator +(Ratio other) => Ratio(
    numerator * other.denominator + other.numerator * denominator,
    denominator * other.denominator,
  );

  Ratio operator -(Ratio other) => Ratio(
    numerator * other.denominator - other.numerator * denominator,
    denominator * other.denominator,
  );

  Ratio operator *(Ratio other) =>
      Ratio(numerator * other.numerator, denominator * other.denominator);

  Ratio operator /(Ratio other) {
    if (other.numerator == BigInt.zero) {
      throw ArgumentError('Division by zero');
    }
    return Ratio(numerator * other.denominator, denominator * other.numerator);
  }

  Ratio operator -() => Ratio._(-numerator, denominator);

  bool get isNegative => numerator.isNegative;
  bool get isZero => numerator == BigInt.zero;

  /// Rounds to the nearest integer, ties away from zero (commercial rounding).
  int roundHalfUp() {
    final twice = numerator * BigInt.two;
    final twiceDen = denominator * BigInt.two;
    final abs = (twice.abs() + denominator) ~/ twiceDen;
    return (numerator.isNegative ? -abs : abs).toInt();
  }

  /// Smallest integer greater than or equal to this value.
  int ceil() {
    final q = numerator ~/ denominator;
    final hasRemainder = numerator.remainder(denominator) != BigInt.zero;
    return (hasRemainder && !numerator.isNegative ? q + BigInt.one : q).toInt();
  }

  @override
  int compareTo(Ratio other) =>
      (numerator * other.denominator).compareTo(other.numerator * denominator);

  bool operator <(Ratio other) => compareTo(other) < 0;
  bool operator <=(Ratio other) => compareTo(other) <= 0;
  bool operator >(Ratio other) => compareTo(other) > 0;
  bool operator >=(Ratio other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      other is Ratio &&
      other.numerator == numerator &&
      other.denominator == denominator;

  @override
  int get hashCode => Object.hash(numerator, denominator);

  @override
  String toString() => '$numerator/$denominator';
}
