// Counter event...
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class ResetCounter extends CounterEvent {}

// Drag Event...
abstract class DragCounterEvent {}

class DragCounter extends DragCounterEvent {
  final double dragOffset;
  final double scale;
  DragCounter(this.dragOffset, this.scale);
}

class ResetDragCounter extends DragCounterEvent {}
