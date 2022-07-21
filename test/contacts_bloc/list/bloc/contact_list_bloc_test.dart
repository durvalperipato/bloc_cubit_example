import 'package:bloc_cubit_example/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  //declaração
  late ContactsRepository repository;
  late ContactListBloc bloc;
  late List<ContactModel> contacts;

  //preparaçao
  setUp(() {
    repository = MockContactsRepository();
    bloc = ContactListBloc(repository: repository);
    contacts = [
      ContactModel(name: 'Durval', email: 'email@durval.com'),
      ContactModel(name: 'Uliane', email: 'email@uliane.com'),
    ];
  });

  //execução
  blocTest<ContactListBloc, ContactListState>(
    'Deve buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(ContactListEvent.findAll()),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );
  blocTest<ContactListBloc, ContactListState>(
    'Deve retornar erro ao buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(ContactListEvent.findAll()),
    setUp: () {
      when(() => repository.findAll()).thenThrow(Exception());
    },
    expect: () => [
      ContactListState.loading(),
      ContactListState.error(error: 'Erro ao buscar os contatos'),
    ],
  );
}
