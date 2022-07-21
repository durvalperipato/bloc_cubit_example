import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_cubit.freezed.dart';
part 'contact_register_state.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterCubitState> {
  final ContactsRepository _repository;

  ContactRegisterCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactRegisterCubitState.initial());

  Future<void> save({required String name, required String email}) async {
    try {
      emit(ContactRegisterCubitState.loading());
      //await Future.delayed(const Duration(seconds: 2));
      final model = ContactModel(name: name, email: email);
      await _repository.create(model);
      emit(ContactRegisterCubitState.success());
    } catch (e, s) {
      log('Erro ao cadastrar usuário', error: e, stackTrace: s);
      emit(ContactRegisterCubitState.error(
          message: 'Erro ao cadastrar usuário'));
    }
  }
}
