import 'dart:ui' show lerpDouble;
import 'package:flutter/foundation.dart';

@immutable
class FancyBorderStyle with Diagnosticable {
  const FancyBorderStyle(
    this.pattern, {
    this.offset = 0,
    this.absolute = false,
  });

  static const solid = FancyBorderStyle([1, 0]);
  static const dotted = FancyBorderStyle([1]);
  static const dashed = FancyBorderStyle([3, 2]);
  static const morse = FancyBorderStyle([3, 2, 1, 2]);

  final List<double> pattern;
  final double offset;
  final bool absolute;

  bool get isSolid => listEquals(pattern, FancyBorderStyle.solid.pattern);

  bool get isNonSolid => !isSolid;

  static FancyBorderStyle? lerp(
      FancyBorderStyle? a, FancyBorderStyle? b, double t) {
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
      offset: lerpDouble(a.offset, b.offset, t) ?? 0,
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
        other.offset == offset &&
        other.absolute == absolute;
  }

  @override
  int get hashCode => Object.hash(pattern, offset, absolute);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('pattern', pattern));
    properties.add(DoubleProperty('offset', offset));
    properties.add(DiagnosticsProperty<bool>('absolute', absolute));
  }
}
