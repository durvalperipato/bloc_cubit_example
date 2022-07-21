import 'package:bloc_cubit_example/contacts_bloc/register/bloc/contact_register_bloc.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRegisterPage extends StatefulWidget {
  const ContactRegisterPage({Key? key}) : super(key: key);

  @override
  State<ContactRegisterPage> createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

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
        title: const Text('Register'),
      ),
      body: BlocListener<ContactRegisterBloc, ContactRegisterState>(
        listenWhen: (previous, current) => current.maybeWhen(
          success: () => true,
          error: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.whenOrNull(
            success: () => Navigator.of(context).pop(),
            error: (error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
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
                      context.read<ContactRegisterBloc>().add(
                            ContactRegisterEvent.save(
                                name: _nameEC.text, email: _emailEC.text),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactRegisterBloc, ContactRegisterState>(
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
