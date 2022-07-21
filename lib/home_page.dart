import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/bloc'),
              child: Text(
                'Bloc',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/cubit'),
              child: Text(
                'Cubit',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/desafio'),
              child: Text(
                'Desafio',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/bloc/freezed'),
              child: Text(
                'Freezed',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/contacts/list'),
              child: Text(
                'Contacts',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/contacts/cubit/list'),
              child: Text(
                'Contacts Cubit',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
