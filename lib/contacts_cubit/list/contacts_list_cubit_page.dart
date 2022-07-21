import 'package:bloc_cubit_example/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListCubitPage extends StatelessWidget {
  const ContactsListCubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List Cubit'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<ContactListCubit>().findAll(),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactListCubit, ContactListCubitState>(
                    selector: (state) => state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                  ),
                  BlocSelector<ContactListCubit, ContactListCubitState,
                          List<ContactModel>>(
                      selector: (state) => state.maybeWhen(
                          data: (contacts) => contacts,
                          orElse: () => <ContactModel>[]),
                      builder: (_, contacts) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: contacts.length,
                            itemBuilder: (_, index) {
                              final contact = contacts[index];
                              return ListTile(
                                title: Text(contact.name),
                                subtitle: Text(contact.email),
                                onTap: () async {
                                  await Navigator.of(context).pushNamed(
                                      '/contacts/cubit/update',
                                      arguments: contact);
                                  // ignore: use_build_context_synchronously
                                  context.read<ContactListCubit>().findAll();
                                },
                                trailing: IconButton(
                                  onPressed: () => context
                                      .read<ContactListCubit>()
                                      .deleteByModel(model: contact),
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/contacts/cubit/register');
          // ignore: use_build_context_synchronously
          context.read<ContactListCubit>().findAll();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
