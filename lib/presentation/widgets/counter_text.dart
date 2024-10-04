import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter/counter_bloc.dart';
import '../../bloc/counter/counter_state.dart';
import '../../bloc/drag_counter/drag_counter_bloc.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required this.dragBloc,
  });
  final DragCounterBloc dragBloc;

  @override
  Widget build(BuildContext context) {
    double maxDistance = max(
        10,
        (MediaQuery.of(context).size.width / 2 - 70) -
            dragBloc.state.dragOffset.abs());

    return AnimatedPositioned(
      left: dragBloc.state.dragOffset >= 0 ? null : maxDistance + 0.35,
      right: dragBloc.state.dragOffset <= 0 ? null : maxDistance + 0.35,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: const Color(0xFF2c2c2c),
          border: Border.all(
            width: 2.0,
            color: maxDistance == 10.0
                ? dragBloc.state.dragOffset > 0
                    ? Colors.green
                    : Colors.red
                : Colors.white24,
          ),
          shape: BoxShape.circle,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Transform.scale(
            scale: dragBloc.state.scale,
            child: BlocBuilder<CounterBloc, CounterState>(
              builder: (context, counterState) {
                return Text(
                  '${counterState.counterValue}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
