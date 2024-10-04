import 'package:flutter/material.dart';

class ButtonInfoIndicator extends StatelessWidget {
  const ButtonInfoIndicator({
    super.key,
    required this.message,
    required this.child,
  });
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        verticalOffset: 50.0,
        preferBelow: false,
        message: message,
        child: child);
  }
}
