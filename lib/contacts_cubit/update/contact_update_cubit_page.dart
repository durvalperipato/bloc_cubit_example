import 'package:bloc_cubit_example/contacts_cubit/update/cubit/contact_update_cubit.dart';
import 'package:bloc_cubit_example/models/contact_model.dart';
import 'package:bloc_cubit_example/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUpdateCubitPage extends StatefulWidget {
  final ContactModel contact;
  const ContactUpdateCubitPage({Key? key, required this.contact})
      : super(key: key);

  @override
  State<ContactUpdateCubitPage> createState() => _ContactUpdateCubitPageState();
}

class _ContactUpdateCubitPageState extends State<ContactUpdateCubitPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  @override
  void initState() {
    _nameEC = TextEditingController(text: widget.contact.name);
    _emailEC = TextEditingController(text: widget.contact.email);
    super.initState();
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
        title: const Text('Contact Update Cubit Page'),
      ),
      body: BlocListener<ContactUpdateCubit, ContactUpdateCubitState>(
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
                        context.read<ContactUpdateCubit>().update(
                            id: widget.contact.id!,
                            name: _nameEC.text,
                            email: _emailEC.text);
                      }
                    },
                    child: const Text('Update'),
                  ),
                  Loader<ContactUpdateCubit, ContactUpdateCubitState>(
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
