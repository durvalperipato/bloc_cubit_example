import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_event.dart';
part 'freezed_state.dart';
part 'freezed_bloc.freezed.dart';

class FreezedBloc extends Bloc<FreezedEvent, FreezedState> {
  FreezedBloc() : super(FreezedState.initial()) {
    on<_FreezedEventFindNames>(_findNames);
    on<_FreezedEventAddName>(_addName);
    on<_FreezedEventRemoveName>(_removeName);
  }

  FutureOr<void> _findNames(
      _FreezedEventFindNames event, Emitter<FreezedState> emit) async {
    emit(FreezedState.loading());
    await Future.delayed(const Duration(seconds: 1));
    emit(FreezedState.data(names: ['Durval Peripato Neto', 'Uliane Arruda']));
  }

  FutureOr<void> _removeName(
      _FreezedEventRemoveName event, Emitter<FreezedState> emit) async {
    final names =
        state.maybeWhen(data: (names) => names, orElse: () => const <String>[]);
    emit(FreezedState.showBanner(
        names: names, message: 'Usuário ${event.name} excluído com sucesso'));
    final newNames = [...names];
    newNames.retainWhere((element) => element != event.name);
    emit(FreezedState.data(names: newNames));
  }

  FutureOr<void> _addName(
      _FreezedEventAddName event, Emitter<FreezedState> emit) async {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );

    emit(FreezedState.showBanner(
        names: names, message: 'Nome ${event.name} sendo adicionado...'));
    await Future.delayed(const Duration(seconds: 4));
    final newNames = [...names];
    newNames.add(event.name);
    emit(FreezedState.data(names: newNames));
  }
}
