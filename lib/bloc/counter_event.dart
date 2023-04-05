abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {
  final int countIndex;
  IncrementCounterEvent(this.countIndex);
}
