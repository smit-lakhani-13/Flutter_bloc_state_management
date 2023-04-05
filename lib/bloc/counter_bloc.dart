import 'package:bloc/bloc.dart';
import 'package:bloc_counter/bloc/counter_event.dart';
import 'package:bloc_counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final List<int> _counts = [0, 0, 0];

  CounterBloc() : super(CounterState(count: 0)) {
    on<IncrementCounterEvent>((event, emit) {
      _counts[event.countIndex]++;
      emit(CounterState(count: _counts[event.countIndex]));
    });
  }
}
