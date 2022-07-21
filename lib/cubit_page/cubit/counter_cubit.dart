import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  void increment() {
    emit(CounterData(state.counter + 1));
  }

  void decrement() {
    emit(CounterData(state.counter - 1));
  }
}
