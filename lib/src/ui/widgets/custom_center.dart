import 'package:flutter/material.dart';

class CustomCenter extends StatelessWidget {
  const CustomCenter({
    super.key,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
