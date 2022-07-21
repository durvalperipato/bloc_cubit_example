import 'package:bloc_cubit_example/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  //declaração
  late ContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

  //preparaçao
  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(repository: repository);
    contacts = [
      ContactModel(name: 'Contato 1', email: 'email@contato1.com'),
      ContactModel(name: 'Contato 2', email: 'email@contato2.com'),
    ];
  });

  //execução
  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );
  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve retornar erro ao buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(() => repository.findAll()).thenThrow(Exception());
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.error(error: 'Erro ao buscar os contatos'),
    ],
  );

  blocTest<ContactListCubit, ContactListCubitState>('Deve deletar o contato',
      build: () => cubit,
      act: (cubit) => cubit.deleteByModel(model: contacts[1]),
      wait: const Duration(seconds: 1),
      setUp: () {
        when(() => repository.delete(contacts[1])).thenAnswer((_) async {
          contacts.removeWhere((element) => element == contacts[1]);
          when(() => repository.findAll()).thenAnswer(
            (_) async => contacts,
          );
        });
      },
      expect: () => [
            ContactListCubitState.loading(),
            ContactListCubitState.data(contacts: contacts),
          ]);
  blocTest<ContactListCubit, ContactListCubitState>(
      'Deve enviar um erro ao deletar o contato',
      build: () => cubit,
      act: (cubit) => cubit.deleteByModel(model: contacts[1]),
      setUp: () =>
          when(() => repository.delete(contacts[1])).thenThrow(Exception()),
      expect: () => [
            ContactListCubitState.loading(),
            ContactListCubitState.error(error: 'Erro ao deletar usuário'),
          ]);
}
