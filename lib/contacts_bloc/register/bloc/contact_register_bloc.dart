import 'dart:async';
import 'dart:developer';

import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_event.dart';
part 'contact_register_state.dart';
part 'contact_register_bloc.freezed.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactsRepository _contactsRepository;

  ContactRegisterBloc({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const ContactRegisterState.initial()) {
    on<_Save>(_save);
  }

  Future<void> _save(_Save event, Emitter<ContactRegisterState> emit) async {
    try {
      emit(const ContactRegisterState.loading());
      await Future.delayed(const Duration(seconds: 2));
      final contactModel = ContactModel(name: event.name, email: event.email);
      await _contactsRepository.create(contactModel);
      emit(const ContactRegisterState.success());
    } on Exception catch (e) {
      log('Erro ao salvar novo registro', error: e);
      emit(const ContactRegisterState.error(
          message: 'Erro ao salvar novo registro'));
    }
  }
}
