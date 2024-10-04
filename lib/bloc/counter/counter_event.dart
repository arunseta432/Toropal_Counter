// Counter event...
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class ResetCounter extends CounterEvent {}

