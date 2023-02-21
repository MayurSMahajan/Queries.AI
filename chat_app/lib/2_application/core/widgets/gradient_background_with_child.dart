import 'package:flutter/material.dart';

class GradientBackgroundwithChild extends StatelessWidget {
  const GradientBackgroundwithChild({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradientStartColor = Theme.of(context).colorScheme.surfaceVariant;
    final gradientEndColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              stops: const [0.7, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: child);
  }
}
