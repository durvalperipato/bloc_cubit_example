part of 'lista_bloc.dart';

abstract class ListaState {}

class ListaStateInitial extends ListaState {}

class ListaStateData extends ListaState {
  final List<String> nomes;

  ListaStateData({required this.nomes});
}
