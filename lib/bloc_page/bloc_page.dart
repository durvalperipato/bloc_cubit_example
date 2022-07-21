import 'package:bloc_cubit_example/bloc_page/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPage extends StatelessWidget {
  const BlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: ((context, state) => Text(
                    'Contador ${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<CounterBloc>().add(CounterIncrement());
              },
              icon: const Icon(Icons.add),
              label: const Text(''),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<CounterBloc>().add(CounterDecrement());
              },
              icon: const Icon(Icons.remove),
              label: const Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
