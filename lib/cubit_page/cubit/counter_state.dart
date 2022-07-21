part of 'counter_cubit.dart';

abstract class CounterState {
  final int counter;

  CounterState(this.counter);
}

class CounterInitial extends CounterState {
  CounterInitial() : super(0);
}

class CounterData extends CounterState {
  CounterData(super.counter);
}
