import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/presentation/index.dart';
import 'package:toropal_counter/bloc/index.dart';

class ResetCounterButton extends StatelessWidget {
  const ResetCounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonInfoIndicator(
      message: "Press to reset the counter",
      child: Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF262626),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 2,
            color: Colors.white24,
          ),
        ),
        height: 60.0,
        child: TextButton(
          onPressed: () {
            HapticFeedback.vibrate();
            context.read<CounterBloc>().add(
                  ResetCounter(),
                );
          },
          child: const Text(
            "Reset Counter",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
