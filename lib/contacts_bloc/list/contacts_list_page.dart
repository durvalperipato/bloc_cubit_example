import 'package:bloc_cubit_example/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) => current.maybeWhen(
          error: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) => state.whenOrNull(
          error: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<ContactListBloc>().add(ContactListEvent.findAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactListBloc, ContactListState>(
                      selector: (state) => state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      ),
                    ),
                    BlocSelector<ContactListBloc, ContactListState,
                        List<ContactModel>>(
                      selector: (state) => state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => [],
                      ),
                      builder: (_, contacts) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contacts.length,
                        itemBuilder: (_, index) {
                          final contact = contacts[index];
                          return ListTile(
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                              trailing: IconButton(
                                onPressed: () async {
                                  context.read<ContactListBloc>().add(
                                      ContactListEvent.delete(
                                          contact: contacts.elementAt(index)));
                                },
                                icon: const Icon(Icons.delete_forever),
                                color: Colors.red,
                              ),
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                    '/contacts/update',
                                    arguments: contact);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<ContactListBloc>()
                                    .add(ContactListEvent.findAll());
                              });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/contacts/register');
          // ignore: use_build_context_synchronously
          context.read<ContactListBloc>().add(ContactListEvent.findAll());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
