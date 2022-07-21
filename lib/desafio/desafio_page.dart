import 'package:bloc_cubit_example/desafio/bloc/lista_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesafioPage extends StatelessWidget {
  const DesafioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<ListaBloc, ListaState, bool>(
              selector: (state) => state is! ListaStateData,
              builder: (_, showLoading) {
                return Visibility(
                  visible: showLoading,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              },
            ),
            BlocBuilder<ListaBloc, ListaState>(
              builder: (_, state) {
                if (state is ListaStateData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.nomes.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(
                        state.nomes.elementAt(index),
                      ),
                      onTap: () {
                        context.read<ListaBloc>().add(
                              RemoveNameEvent(
                                name: state.nomes.elementAt(index),
                              ),
                            );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<ListaBloc>().add(
              AddNameEvent(name: 'Durval'),
            ),
      ),
    );
  }
}
