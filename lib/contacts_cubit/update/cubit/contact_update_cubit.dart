import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_cubit.freezed.dart';
part 'contact_update_state.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateCubitState> {
  final ContactsRepository _repository;

  ContactUpdateCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactUpdateCubitState.initial());

  Future<void> update(
      {required String id, required String name, required String email}) async {
    try {
      emit(const ContactUpdateCubitState.loading());
      final model = ContactModel(id: id, name: name, email: email);
      await _repository.update(model);
      emit(const ContactUpdateCubitState.success());
    } on Exception catch (e, s) {
      log('Erro ao autalizar o contato', error: e, stackTrace: s);
      emit(const ContactUpdateCubitState.error(
          message: 'Erro ao atualizar o contato'));
    }
  }
}
