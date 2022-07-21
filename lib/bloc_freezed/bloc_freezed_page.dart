import 'package:bloc_cubit_example/bloc_freezed/bloc/freezed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreezedPage extends StatelessWidget {
  const FreezedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed Page'),
      ),
      body: BlocListener<FreezedBloc, FreezedState>(
        listener: (_, state) => state.whenOrNull(
          showBanner: (_, message) =>
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          ),
        ),
        child: Column(
          children: [
            BlocSelector<FreezedBloc, FreezedState, bool>(
              selector: (state) =>
                  state.maybeWhen(loading: () => true, orElse: () => false),
              builder: (_, showLoading) => Visibility(
                visible: showLoading,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            BlocSelector<FreezedBloc, FreezedState, List<String>>(
              selector: (state) => state.maybeWhen(
                  data: (names) => names,
                  showBanner: (names, _) => names,
                  orElse: () => []),
              builder: (_, names) => ListView.builder(
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(
                    names.elementAt(index),
                  ),
                  onTap: () => context.read<FreezedBloc>().add(
                        FreezedEvent.removeName(
                          name: names.elementAt(index),
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<FreezedBloc>().add(
              FreezedEvent.addName(name: 'Durval'),
            ),
      ),
    );
  }
}
