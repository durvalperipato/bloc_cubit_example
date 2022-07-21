import 'dart:async';

import 'package:bloc/bloc.dart';

part 'lista_state.dart';
part 'lista_event.dart';

class ListaBloc extends Bloc<ListaEvent, ListaState> {
  ListaBloc() : super(ListaStateInitial()) {
    on<AddNameEvent>(_addName);
    on<RemoveNameEvent>(_removeName);
    on<FindNameEvent>(_findNames);
  }

  FutureOr<void> _findNames(
      FindNameEvent event, Emitter<ListaState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(ListaStateData(nomes: ['Durval Peripato Neto', 'Uliane Arruda']));
  }

  FutureOr<void> _removeName(
      RemoveNameEvent event, Emitter<ListaState> emit) async {
    // Para conseguir fazer a promoção da variável
    final stateList = state;
    if (stateList is ListaStateData) {
      // Como não esta usando o Equatable ou get operator == na classe é necessário gerar uma outra variável
      final names = [...stateList.nomes];
      names.retainWhere((element) => element != event.name);
      emit(ListaStateData(nomes: names));
    }
  }

  FutureOr<void> _addName(AddNameEvent event, Emitter<ListaState> emit) async {
    final stateList = state;
    if (stateList is ListaStateData) {
      final names = [...stateList.nomes];
      names.add(event.name);
      emit(ListaStateData(nomes: names));
    }
  }
}
