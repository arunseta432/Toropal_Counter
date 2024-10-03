import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  double _dragOffset = 0.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
  }

  void _onDragEnd(CounterBloc bloc) {
    if (_dragOffset.abs() > 100) {
      // Increment if dragged to the right, Decrement if dragged to the left
      if (_dragOffset > 0) {
        bloc.add(Increment());
      } else {
        bloc.add(Decrement());
      }
    }
    setState(() {
      _dragOffset = 0;
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final dragBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF2c2c2c),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 30),
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            color: const Color(0xFF262626),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey.shade50,
              width: 0.5,
            ),
          ),
          height: 100.0 + (_dragOffset.abs() / 10),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragOffset += details.primaryDelta ?? 0.0;
                _scale = 1.0 -
                    min(
                        0.3,
                        _dragOffset.abs() /
                            500); // Adjust the scale as you drag
              });
            },
            onHorizontalDragEnd: (details) => _onDragEnd(counterBloc),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  top: 7.5,
                  bottom: 7.5,
                  left: _dragOffset > 0 ? null : 125 - _dragOffset.abs(),
                  right: _dragOffset < 0 ? null : 125 - _dragOffset.abs(),
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 85.0,
                    height: 85.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3b3b3b),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () => counterBloc.add(Decrement()),
                      icon: const Icon(Icons.remove, color: Color(0xFF767676)),
                      iconSize: 40,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    BlocBuilder<CounterBloc, CounterState>(
                        builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: Transform.scale(
                          scale: _scale,
                          child: Text(
                            '${state.counterValue}',
                            key: ValueKey<int>(state.counterValue),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                    IconButton(
                      onPressed: () => counterBloc.add(Increment()),
                      icon: const Icon(Icons.add, color: Color(0xFF767676)),
                      iconSize: 40,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
