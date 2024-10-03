import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(
          state.counterValue + 1,
        )));
    on<Decrement>((event, emit) => emit(CounterState(state.counterValue - 1)));
    on<ResetCounter>((event, emit) => emit(CounterState(0)));
  }
}

class DragCounterBloc extends Bloc<DragCounterEvent, DragCounterState> {
  DragCounterBloc() : super(DragCounterState(0, 1)) {
    on<DragCounter>(
      (event, emit) => emit(
        DragCounterState(
          state.dragOffset + event.dragOffset,
          event.scale,
        ),
      ),
    );
    on<ResetDragCounter>(
      (event, emit) => emit(
        DragCounterState(
          0,
          1.0,
        ),
      ),
    );
  }
}
