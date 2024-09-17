import 'package:flutter/material.dart';

class CustomSectionContainer extends StatelessWidget {
  final double? width;
  final Color? color;
  final Widget? child;
  final double? borderRadius;
  const CustomSectionContainer(
      {super.key, this.width, this.color, this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: size.width < 400
          ? const EdgeInsets.all(15)
          : EdgeInsets.all(size.width < 500 ? 0 : size.width * 0.02),
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      child: Padding(
        padding: size.width < 400
            ? const EdgeInsets.only()
            : const EdgeInsets.only(left: 30, right: 30),
        child: child,
      ),
    );
  }
}
