import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/bloc/index.dart';
import 'package:toropal_counter/presentation/index.dart';

void main() {
  runApp(const ToropalCounterApp());
}

class ToropalCounterApp extends StatelessWidget {
  const ToropalCounterApp({super.key});

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
