import 'package:flutter/material.dart';

extension CustomWidget on Widget {
  Widget get expandBothAxis => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: this,
      );

  Widget paddingVertical4() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: this,
      );

  Widget paddingAll4() => Padding(
        padding: const EdgeInsets.all(4),
        child: this,
      );
}

class CircleContainer extends StatelessWidget {
  const CircleContainer(
      {super.key,
      this.child,
      this.maxRadius,
      this.radius,
      this.fillColor,
      this.outlineWidth,
      this.outlined = false});
  final Widget? child;
  final double? maxRadius;
  final double? radius;
  final Color? fillColor;
  final bool outlined;
  final double? outlineWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
        maxWidth: maxRadius == null ? double.infinity : maxRadius! * 2,
        maxHeight: maxRadius == null ? double.infinity : maxRadius! * 2,
        minWidth: radius == null ? 0 : radius! * 2,
        minHeight: radius == null ? 0 : radius! * 2,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: !outlined ? fillColor ?? Colors.black : null,
        border: outlined
            ? Border.all(
                color: fillColor ?? Colors.black, width: outlineWidth ?? 1.0)
            : null,
      ),
      child: child ??
          Container(
            width: radius ?? 0,
          ),
    );
  }
}
