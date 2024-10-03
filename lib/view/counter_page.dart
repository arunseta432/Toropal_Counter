import 'package:flutter/material.dart';
import 'package:toropal_counter/view/counter_component.dart';
import 'package:toropal_counter/view/reset_counter_button.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF2c2c2c),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterComponent(),
          ResetCounterButton(),
        ],
      ),
    );
  }
}
