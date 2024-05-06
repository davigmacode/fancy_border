import 'dart:ui' show PathMetric;
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'style.dart';

//// A custom Flutter border class that allows for drawing fancy borders
/// with gradients and patterns, while still supporting built-in shape borders.
///
/// This class provides a way to create borders with more flexibility than
/// the standard `OutlinedBorder` class. It supports solid borders, gradients,
/// and patterns like dotted or dashed lines.
@immutable
class FancyBorder extends ShapeBorder {
  /// Creates a new instance of [FancyBorder].
  ///
  /// The `shape` argument defines the underlying shape of the border.
  /// Defaults to a `RoundedRectangleBorder`.
  ///
  /// The `style` argument defines the style of the border.
  /// Defaults to [FancyBorderStyle.solid].
  ///
  /// The `color` argument defines the color of the border.
  ///
  /// The `gradient` argument defines the gradient to use for the border.
  ///
  /// The `width` argument defines the width of the border.
  ///
  /// The `offset` argument defines the offset of the border stroke.
  ///
  /// The `corners` argument defines the corner radius of the border.
  const FancyBorder({
    this.shape,
    this.style = FancyBorderStyle.solid,
    this.color,
    this.gradient,
    this.width,
    this.offset,
    this.corners,
  }) : assert(width == null || width >= 0);

  /// The underlying border shape.
  final OutlinedBorder? shape;

  /// The style of the border.
  final FancyBorderStyle style;

  /// The color of the border.
  final Color? color;

  /// The gradient to use for the border.
  final Gradient? gradient;

  /// The width of the border.
  final double? width;

  /// The offset of the border stroke.
  final double? offset;

  /// The corner radius of the border.
  final BorderRadiusGeometry? corners;

  /// Returns the effective border shape after considering all properties.
  OutlinedBorder get effectiveShape {
    OutlinedBorder actualShape = shape ?? const RoundedRectangleBorder();
    actualShape = actualShape.copyWith(
      side: actualShape.side.copyWith(
        style: style == FancyBorderStyle.solid
            ? BorderStyle.solid
            : BorderStyle.none,
        color: color,
        width: width,
        strokeAlign: offset,
      ),
    );

    if (actualShape is RoundedRectangleBorder) {
      actualShape = actualShape.copyWith(borderRadius: corners);
    } else if (actualShape is ContinuousRectangleBorder) {
      actualShape = actualShape.copyWith(borderRadius: corners);
    } else if (actualShape is BeveledRectangleBorder) {
      actualShape = actualShape.copyWith(borderRadius: corners);
    }

    return actualShape;
  }

  @override
  EdgeInsetsGeometry get dimensions => effectiveShape.dimensions;

  @override
  bool get preferPaintInterior => effectiveShape.preferPaintInterior;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return effectiveShape.getInnerPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return effectiveShape.getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paintInterior(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    TextDirection? textDirection,
  }) {
    effectiveShape.paintInterior(canvas, rect, paint,
        textDirection: textDirection);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final side = effectiveShape.side;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = side.width
      ..color = side.color
      ..shader = gradient?.createShader(rect);

    final offset = side.strokeOffset / 2;
    final borderRect = rect.inflate(offset);

    if (preferPaintInterior && style == FancyBorderStyle.solid) {
      paintInterior(canvas, borderRect, paint);
      return;
    }

    Path path = getOuterPath(
      borderRect,
      textDirection: textDirection,
    );

    if (style != FancyBorderStyle.solid) {
      path = getNonSolidPath(
        path,
        textDirection: textDirection,
      );
    }

    canvas.drawPath(path, paint);
  }

  /// Creates a copy of this [FancyBorder] object with potentially overridden
  /// properties.
  ///
  /// Returns a new [FancyBorder] object with the given parameters overridden.
  /// This method is useful for expressing small variations of an existing
  /// [FancyBorder] object.
  FancyBorder copyWith({
    OutlinedBorder? shape,
    FancyBorderStyle? style,
    Color? color,
    Gradient? gradient,
    double? width,
    double? offset,
  }) {
    return FancyBorder(
      shape: shape ?? this.shape,
      style: style ?? this.style,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      width: width ?? this.width,
      offset: offset ?? this.offset,
    );
  }

  /// Calculates the path for a non-solid border style (e.g. dotted or
  /// dashed).
  ///
  /// This method iterates over the [style.pattern] to create a path with
  /// gaps according to the pattern.
  ///
  /// Arguments:
  ///   * `source`: The source path to be modified.
  ///   * `textDirection`: The text direction for drawing the path.
  ///
  /// Returns a new path object representing the non-solid border.
  Path getNonSolidPath(Path source, {TextDirection? textDirection}) {
    final Path dest = Path();
    final sideWidth = effectiveShape.side.width;
    for (final PathMetric metric in source.computeMetrics()) {
      int index = 0;
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        if (index >= style.pattern.length) {
          index = 0;
        }
        final double mul = style.absolute ? 1 : sideWidth;
        final double len = style.pattern[index++] * mul;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  ShapeBorder scale(double t) {
    return copyWith(
      shape: effectiveShape.scale(t) as OutlinedBorder,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is FancyBorder) {
      return FancyBorder(
        shape: effectiveShape.lerpFrom(a.effectiveShape, t) as OutlinedBorder?,
        style: FancyBorderStyle.lerp(a.style, style, t)!,
        gradient: Gradient.lerp(a.gradient, gradient, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is FancyBorder) {
      return FancyBorder(
        shape: effectiveShape.lerpTo(b.effectiveShape, t) as OutlinedBorder?,
        style: FancyBorderStyle.lerp(style, b.style, t)!,
        gradient: Gradient.lerp(gradient, b.gradient, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FancyBorder &&
        other.shape == shape &&
        other.style == style &&
        other.color == color &&
        other.gradient == gradient &&
        other.width == width &&
        other.offset == offset &&
        other.corners == corners;
  }

  @override
  int get hashCode =>
      Object.hash(shape, style, color, gradient, width, offset, corners);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'FancyBorder')}($shape, $style, $color, $gradient, $width, $offset, $offset)';
  }
}
