import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toropal_counter/presentation/index.dart';

class CounterIncrementDecrementButton extends StatelessWidget {
  const CounterIncrementDecrementButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xFF767676),
    this.message,
  });
  final IconData? icon;
  final void Function() onPressed;
  final Color? color;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return ButtonInfoIndicator(
      message: message ?? "",
      child: IconButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          onPressed();
        },
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 40.0, color: color),
        ),
        iconSize: 60,
      ),
    );
  }
}
