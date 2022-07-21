import 'package:bloc_cubit_example/contacts_cubit/register/cubit/contact_register_cubit.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockDio extends Mock implements Dio {}

void main() {
  late ContactsRepository repository;
  late ContactRegisterCubit cubit;
  late List<ContactModel> contacts;
  late ContactModel model;
  late Dio dio;

  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactRegisterCubit(repository: repository);
    contacts = [
      ContactModel(name: 'Contato1', email: 'email1'),
      ContactModel(name: 'Contato2', email: 'email2'),
    ];
    model = ContactModel(name: 'Contato3', email: 'email3');
    dio = MockDio();
  });
  blocTest<ContactRegisterCubit, ContactRegisterCubitState>(
    'Deve registrar um novo usuário',
    build: () => cubit,
    act: (cubit) => cubit.save(name: model.name, email: model.email),
    setUp: () => when(
      () => repository.create(model),
    ).thenAnswer((_) async => dio.post('path', data: model.toMap())),
    expect: () => [
      ContactRegisterCubitState.loading(),
      ContactRegisterCubitState.success(),
    ],
  );
}
