import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/presentation/index.dart';
import 'package:toropal_counter/bloc/index.dart';

class CounterComponent extends StatelessWidget {
  const CounterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final dragBloc = BlocProvider.of<DragCounterBloc>(context);

    return BlocBuilder<DragCounterBloc, DragCounterState>(
      builder: (context, dragState) {
        double maxDistance = max(
            10,
            (MediaQuery.of(context).size.width / 2 - 70) -
                dragBloc.state.dragOffset.abs());

        // Drag Gesture...
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            final double dragOffset = (details.primaryDelta ?? 0.0);
            final double scale =
                1.0 + min(0.6, dragBloc.state.dragOffset.abs() / 500);
            dragBloc.add(DragCounter(dragOffset, scale));
          },
          onHorizontalDragEnd: (details) => _onDragEnd(counterBloc, dragBloc),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color(0xFF262626),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 2,
                // Show highlighted border based on increment decrement event...
                color: maxDistance == 10.0
                    ? dragBloc.state.dragOffset > 0
                        ? Colors.green
                        : Colors.red
                    : Colors.white24,
              ),
            ),
            height: 100.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Decrement button...
                      CounterIncrementDecrementButton(
                        message: "Press to decrement the count",
                        icon: Icons.remove,
                        color: Colors.red,
                        onPressed: () => counterBloc.add(
                          Decrement(),
                        ),
                      ),
                      // Increment button...
                      CounterIncrementDecrementButton(
                        message: "Press to increment the count",
                        icon: Icons.add,
                        color: Colors.green,
                        onPressed: () => counterBloc.add(
                          Increment(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Counter Display text...
                CounterText(
                  dragBloc: dragBloc,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDragEnd(CounterBloc bloc, DragCounterBloc dragBloc) {
    if (dragBloc.state.dragOffset.abs() > 100) {
      HapticFeedback.mediumImpact();
      // Increment if dragged to the right, Decrement if dragged to the left
      if (dragBloc.state.dragOffset > 0) {
        bloc.add(Increment());
      } else {
        bloc.add(Decrement());
      }
    }

    // Reset Drag counter to initial position (Center)...
    dragBloc.add(ResetDragCounter());
  }
}
