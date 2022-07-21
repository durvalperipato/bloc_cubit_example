import 'package:bloc_cubit_example/cubit_page/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitPage extends StatelessWidget {
  const CubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<CounterCubit, CounterState, int>(
              selector: (state) => state.counter,
              builder: (_, counter) => Text(
                'Contador $counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              icon: const Icon(Icons.add),
              label: const Text(''),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<CounterCubit>().decrement();
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
