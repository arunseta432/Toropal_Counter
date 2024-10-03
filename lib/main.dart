import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/view/counter_button.dart';
import 'dart:math'; // To calculate direction and distance
import 'counter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (BuildContext context) => CounterBloc(),
        ),
        BlocProvider<DragCounterBloc>(
          create: (BuildContext context) => DragCounterBloc(),
        ),
      ],
      child: const CounterPage(),
    ));
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  void _onDragEnd(CounterBloc bloc, DragCounterBloc dragBloc) {
    if (dragBloc.state.dragOffset.abs() > 100) {
      // Increment if dragged to the right, Decrement if dragged to the left
      if (dragBloc.state.dragOffset > 0) {
        bloc.add(Increment());
      } else {
        bloc.add(Decrement());
      }
    }
    dragBloc.add(ResetDragCounter());
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final dragBloc = BlocProvider.of<DragCounterBloc>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2c2c2c),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<DragCounterBloc, DragCounterState>(
            builder: (context, dragState) {
              double maxDistance = max(
                  10,
                  (MediaQuery.of(context).size.width / 2 - 70) -
                      dragBloc.state.dragOffset.abs());
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final double dragOffset = (details.primaryDelta ?? 0.0);
                  final double scale =
                      1.0 + min(0.6, dragBloc.state.dragOffset.abs() / 500);
                  dragBloc.add(DragCounter(dragOffset, scale));
                },
                onHorizontalDragEnd: (details) =>
                    _onDragEnd(counterBloc, dragBloc),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF262626),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 2,
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
                            CounterButton(
                              icon: Icons.remove,
                              color: Colors.red,
                              onPressed: () => counterBloc.add(
                                Decrement(),
                              ),
                            ),
                            CounterButton(
                              icon: Icons.add,
                              color: Colors.green,
                              onPressed: () => counterBloc.add(
                                Increment(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedPositioned(
                        left:
                            dragBloc.state.dragOffset >= 0 ? null : maxDistance,
                        right:
                            dragBloc.state.dragOffset <= 0 ? null : maxDistance,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.decelerate,
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3b3b3b),
                            border: Border.all(
                                width: 2.0,
                                color: maxDistance == 10.0
                                    ? dragBloc.state.dragOffset > 0
                                        ? Colors.green
                                        : Colors.red
                                    : Colors.white24),
                            shape: BoxShape.circle,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Transform.scale(
                              scale: dragState.scale,
                              child: BlocBuilder<CounterBloc, CounterState>(
                                builder: (context, counterState) {
                                  return Text(
                                    '${counterState.counterValue}',
                                    key: ValueKey<int>(
                                        counterState.counterValue),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
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
              onPressed: () => counterBloc.add(
                ResetCounter(),
              ),
              child: const Text(
                "Reset Counter",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
