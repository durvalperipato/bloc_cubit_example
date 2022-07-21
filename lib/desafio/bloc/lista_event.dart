part of 'lista_bloc.dart';

abstract class ListaEvent {}

class AddNameEvent extends ListaEvent {
  final String name;

  AddNameEvent({required this.name});
}

class FindNameEvent extends ListaEvent {}

class RemoveNameEvent extends ListaEvent {
  final String name;

  RemoveNameEvent({required this.name});
}
