import 'package:flutter/material.dart';
import 'package:toropal_counter/presentation/index.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Toropal",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF2c2c2c),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterComponent(),
          ResetCounterButton(),
        ],
      ),
    );
  }
}
