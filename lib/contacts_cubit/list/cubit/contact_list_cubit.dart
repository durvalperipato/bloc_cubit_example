import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_cubit_state.dart';
part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListCubitState> {
  final ContactsRepository _repository;
  ContactListCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(ContactListCubitState.loading());
      final contacts = await _repository.findAll();
      await Future.delayed(const Duration(seconds: 1));
      emit(ContactListCubitState.data(contacts: contacts));
    } on Exception catch (e, s) {
      log('Erro ao buscar os contatos', error: e, stackTrace: s);
      emit(ContactListCubitState.error(error: 'Erro ao buscar os contatos'));
    }
  }

  Future<void> deleteByModel({required ContactModel model}) async {
    try {
      emit(ContactListCubitState.loading());
      await _repository.delete(model);
      findAll();
    } on Exception catch (e, s) {
      log('Erro ao deletar usuário', error: e, stackTrace: s);
      emit(ContactListCubitState.error(error: 'Erro ao deletar usuário'));
    }
  }
}
