import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        )
      ],
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
}

class SettingProvider extends ChangeNotifier {
  late String text = "INIT";
  late Color color = Colors.red;

  void changeText() {
    if (text == 'Hello') {
      text = "World";
    } else {
      text = "Hello";
    }
    notifyListeners();
  }

  void changeColor() {
    if (color == Colors.red) {
      color = Colors.blue.shade100;
    } else {
      color = Colors.red;
    }
    notifyListeners();
  }
}

class CounterHome extends StatelessWidget {
  const CounterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, setting, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: setting.color,
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Change Color",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Change Text ${setting.text}",
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SettingProvider>().changeText();
                },
                child: Text("ChangeText"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SettingProvider>().changeColor();
                },
                child: Text("ChangeColor"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<CounterProvider>().add();
          },
        ),
      );
    });
  }
}
