import 'package:flutter/material.dart';

class CounterIncrementDecrementButton extends StatelessWidget {
  const CounterIncrementDecrementButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xFF767676),
  });
  final IconData? icon;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 40.0, color: color),
      ),
      iconSize: 60,
    );
  }
}
