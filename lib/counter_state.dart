class CounterState {
  final int counterValue;
  CounterState(this.counterValue);
}

class DragCounterState {
  final double dragOffset;
  final double scale;
  DragCounterState(this.dragOffset, this.scale);
}
