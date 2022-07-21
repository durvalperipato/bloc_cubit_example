import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  // Para conseguir usar o localhost pelo USB no device fisico usar os comandos no terminal
  // adb reverse tcp: (número da porta) tcp: (número da porta)
  // Numero da porta que o dartion gerou ao utilizar dartion serve
  // Comando adb pode usar na pasta onde se encontra o sdk platform tools
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://localhost:3031/contacts');
    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) async =>
      await Dio().post('http://localhost:3031/contacts', data: model.toMap());

  Future<void> update(ContactModel model) async => await Dio()
      .put('http://localhost:3031/contacts/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) async =>
      await Dio().delete('http://localhost:3031/contacts/${model.id}');
}
