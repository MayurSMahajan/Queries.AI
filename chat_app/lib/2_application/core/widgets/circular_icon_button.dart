import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Color btnColor;
  final Widget icon;
  final VoidCallback onTap;

  const CircularIconButton(
      {super.key,
      required this.btnColor,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: btnColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: icon,
        ),
      ),
    );
  }
}
