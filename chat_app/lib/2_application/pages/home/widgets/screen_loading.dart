import 'package:flutter/material.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    return Center(
      child: CircularProgressIndicator(
        color: accentColor,
      ),
    );
  }
}
