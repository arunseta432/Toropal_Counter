import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/counter_bloc.dart';

import '../counter_event.dart';

class ResetCounterButton extends StatelessWidget {
  const ResetCounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 2,
          color: Colors.white24,
        ),
      ),
      height: 50.0,
      child: TextButton(
        onPressed: () => context.read<CounterBloc>().add(
              ResetCounter(),
            ),
        child: const Text(
          "Reset Counter",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
