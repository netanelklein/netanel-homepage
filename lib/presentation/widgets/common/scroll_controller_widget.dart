import 'package:flutter/material.dart';

class ScrollControllerWidget extends StatelessWidget {
  final Widget child;

  const ScrollControllerWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}