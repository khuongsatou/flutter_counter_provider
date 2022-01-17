import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: Scaffold(
        body: CounterHome(),
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  late int _counter = 0;

  int get counter => _counter;

  void add() {
    _counter++;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CounterHome extends StatelessWidget {
  const CounterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.watch<CounterProvider>().counter.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CounterProvider>().add();
        },
      ),
    );
  }
}
