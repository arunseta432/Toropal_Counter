import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toropal_counter/bloc/index.dart';

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
