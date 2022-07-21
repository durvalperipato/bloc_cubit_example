import 'package:bloc_cubit_example/contacts_cubit/register/cubit/contact_register_cubit.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRegisterCubitPage extends StatefulWidget {
  const ContactRegisterCubitPage({Key? key}) : super(key: key);

  @override
  State<ContactRegisterCubitPage> createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterCubitPage> {
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
        title: const Text('Contact Register Cubit Page'),
      ),
      body: BlocListener<ContactRegisterCubit, ContactRegisterCubitState>(
        listenWhen: (previous, current) => current.maybeWhen(
          success: () => true,
          error: (_) => true,
          orElse: () => false,
        ),
        listener: (_, state) => state.maybeWhen(
            success: () => Navigator.of(context).pop(),
            error: (error) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.red,
                  ),
                ),
            orElse: () => false),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameEC,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailEC,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      final validForm =
                          _formKey.currentState?.validate() ?? false;
                      if (validForm) {
                        context
                            .read<ContactRegisterCubit>()
                            .save(name: _nameEC.text, email: _emailEC.text);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  Loader<ContactRegisterCubit, ContactRegisterCubitState>(
                    selector: (state) => state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
