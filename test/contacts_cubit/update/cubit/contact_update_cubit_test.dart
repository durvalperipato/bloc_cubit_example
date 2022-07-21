import 'package:bloc_cubit_example/contacts_cubit/update/cubit/contact_update_cubit.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactUpdateCubit cubit;
  late List<ContactModel> contacts;
  late ContactModel model;

  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactUpdateCubit(repository: repository);
    contacts = [
      ContactModel(name: 'name', email: 'email'),
      ContactModel(name: 'name2', email: 'email2'),
    ];
    model = ContactModel(id: "1", name: "name", email: "email");
  });

  /* blocTest<ContactUpdateCubit, ContactUpdateCubitState>(
    'Deve atualizar os dados de um usuário',
    build: () => cubit,
    act: (cubit) =>
        cubit.update(id: model.id!, name: model.name, email: model.email),
    setUp: () {
      final ContactModel model2 = model;
      when<Future<void>>(() {
        return repository.update(model2);
      }).thenAnswer((_) async {
        return contacts.add(model2);
      });
    },
    expect: () => const [
      ContactUpdateCubitState.loading(),
      ContactUpdateCubitState.success(),
    ],
  ); */
}
