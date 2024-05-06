import 'dart:ui' show lerpDouble;
import 'package:flutter/foundation.dart';

/// A class representing a fancy border style for widgets.
///
/// You can create custom border styles using the constructor or
/// use the built-in constant styles like `solid`, `dotted`, `dashed`,
/// and `morse`.
@immutable
class FancyBorderStyle with Diagnosticable {
  /// Creates a new `FancyBorderStyle` with the specified pattern, offset,
  /// and absolute positioning flag.
  ///
  /// * `pattern`: A list of doubles representing the on/off durations of the
  ///   border pattern. A value of `1` represents "on," and other values
  ///   represent "off."
  /// * `absolute` (default: `false`): Whether the pattern's position is
  ///   relative to the border width (false) or absolute value (true).
  const FancyBorderStyle(
    this.pattern, {
    this.absolute = false,
  });

  /// A constant representing a solid border style.
  static const solid = FancyBorderStyle([1, 0]);

  /// A constant representing a dotted border style.
  static const dotted = FancyBorderStyle([1]);

  /// A constant representing a dashed border style.
  static const dashed = FancyBorderStyle([3, 2]);

  /// A constant representing a Morse code-like border style.
  static const morse = FancyBorderStyle([3, 2, 1, 2]);

  /// The list of doubles defining the on/off durations of the border pattern.
  final List<double> pattern;

  /// Whether the pattern's value is relative to border width value or absolute value.
  final bool absolute;

  /// Checks if the border style is solid (pattern is equal to `FancyBorderStyle.solid.pattern`).
  bool get isSolid => listEquals(pattern, FancyBorderStyle.solid.pattern);

  /// Checks if the border style is non-solid (not equal to `FancyBorderStyle.solid.pattern`).
  bool get isNonSolid => !isSolid;

  /// Creates a lerped (linearly interpolated) border style between two
  /// existing styles.
  ///
  /// * `a`: The first `FancyBorderStyle` (can be null).
  /// * `b`: The second `FancyBorderStyle` (can be null).
  /// * `t`: The interpolation factor (0.0 for `a`, 1.0 for `b`).
  static FancyBorderStyle? lerp(
    FancyBorderStyle? a,
    FancyBorderStyle? b,
    double t,
  ) {
    if (a == null) return b;
    if (b == null) return a;
    final lowestMultiple = a.pattern.length * b.pattern.length;

    return FancyBorderStyle(
      [
        for (int i = 0; i < lowestMultiple; i++)
          lerpDouble(
                a.pattern[i % a.pattern.length],
                b.pattern[i % b.pattern.length],
                t,
              ) ??
              0,
      ],
      absolute: t < 0.5 ? a.absolute : b.absolute,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FancyBorderStyle &&
        listEquals(other.pattern, pattern) &&
        other.absolute == absolute;
  }

  @override
  int get hashCode => Object.hash(pattern, absolute);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('pattern', pattern));
    properties.add(DiagnosticsProperty<bool>('absolute', absolute));
  }
}
