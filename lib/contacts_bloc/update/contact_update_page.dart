// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cubit_example/contacts_bloc/update/bloc/bloc/contact_update_bloc.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contact;
  const ContactUpdatePage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.contact.name);
    _emailEC = TextEditingController(text: widget.contact.email);
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Update'),
      ),
      body: BlocListener<ContactUpdateBloc, ContactUpdateState>(
        listenWhen: (previous, current) => current.maybeWhen(
          success: () => true,
          error: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.whenOrNull(
            success: () => Navigator.pop(context),
            error: (error) => SnackBar(
              content: Text(
                error,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailEC,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      context.read<ContactUpdateBloc>().add(
                            ContactUpdateEvent.save(
                                id: widget.contact.id!,
                                name: _nameEC.text,
                                email: _emailEC.text),
                          );
                    }
                  },
                  child: const Text('Update'),
                ),
                Loader<ContactUpdateBloc, ContactUpdateState>(
                  selector: (state) =>
                      state.maybeWhen(loading: () => true, orElse: () => false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
