import 'package:bloc_cubit_example/bloc_freezed/bloc/freezed_bloc.dart';
import 'package:bloc_cubit_example/bloc_freezed/bloc_freezed_page.dart';
import 'package:bloc_cubit_example/bloc_page/bloc/counter_bloc.dart';
import 'package:bloc_cubit_example/bloc_page/bloc_page.dart';
import 'package:bloc_cubit_example/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:bloc_cubit_example/contacts_bloc/list/contacts_list_page.dart';
import 'package:bloc_cubit_example/contacts_bloc/register/bloc/contact_register_bloc.dart';
import 'package:bloc_cubit_example/contacts_bloc/register/contact_register_page.dart';
import 'package:bloc_cubit_example/contacts_bloc/update/bloc/bloc/contact_update_bloc.dart';
import 'package:bloc_cubit_example/contacts_bloc/update/contact_update_page.dart';
import 'package:bloc_cubit_example/contacts_cubit/list/contacts_list_cubit_page.dart';
import 'package:bloc_cubit_example/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:bloc_cubit_example/contacts_cubit/register/contact_register_cubit_page.dart';
import 'package:bloc_cubit_example/contacts_cubit/register/cubit/contact_register_cubit.dart';
import 'package:bloc_cubit_example/contacts_cubit/update/contact_update_cubit_page.dart';
import 'package:bloc_cubit_example/contacts_cubit/update/cubit/contact_update_cubit.dart';
import 'package:bloc_cubit_example/cubit_page/cubit/counter_cubit.dart';
import 'package:bloc_cubit_example/cubit_page/cubit_page.dart';
import 'package:bloc_cubit_example/desafio/bloc/lista_bloc.dart';
import 'package:bloc_cubit_example/desafio/desafio_page.dart';
import 'package:bloc_cubit_example/home_page.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ContactsRepository(),
      child: MaterialApp(
        title: 'Bloc and Cubit Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/bloc': (_) => BlocProvider(
                create: (_) => CounterBloc(),
                child: const BlocPage(),
              ),
          '/cubit': (_) => BlocProvider(
                create: (_) => CounterCubit(),
                child: const CubitPage(),
              ),
          '/desafio': (_) => BlocProvider(
                create: (_) => ListaBloc()..add(FindNameEvent()),
                child: const DesafioPage(),
              ),
          '/bloc/freezed': (_) => BlocProvider(
                create: (_) =>
                    FreezedBloc()..add(const FreezedEvent.findNames()),
                child: const FreezedPage(),
              ),
          '/contacts/list': (_) => BlocProvider(
                create: (context) => ContactListBloc(
                    repository: context.read<ContactsRepository>())
                  ..add(ContactListEvent.findAll()),
                child: const ContactsListPage(),
              ),
          '/contacts/register': (_) => BlocProvider(
                create: (context) => ContactRegisterBloc(
                    contactsRepository: context.read<ContactsRepository>()),
                child: const ContactRegisterPage(),
              ),
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactUpdateBloc(
                  contactsRepository: context.read<ContactsRepository>()),
              child: ContactUpdatePage(
                contact: contact,
              ),
            );
          },
          '/contacts/cubit/list': (context) => BlocProvider(
                create: (context) => ContactListCubit(
                  repository: context.read<ContactsRepository>(),
                )..findAll(),
                child: const ContactsListCubitPage(),
              ),
          '/contacts/cubit/register': (context) => BlocProvider(
                create: (context) => ContactRegisterCubit(
                  repository: context.read<ContactsRepository>(),
                ),
                child: const ContactRegisterCubitPage(),
              ),
          '/contacts/cubit/update': (context) {
            final contact =
                ModalRoute.of(context)?.settings.arguments as ContactModel;
            return BlocProvider(
              create: (context) => ContactUpdateCubit(
                repository: context.read<ContactsRepository>(),
              ),
              child: ContactUpdateCubitPage(contact: contact),
            );
          }
        },
        home: const HomePage(),
      ),
    );
  }
}
