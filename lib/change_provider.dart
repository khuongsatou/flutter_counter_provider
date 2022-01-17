import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:provider_test/app_model.dart';
import 'package:provider_test/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        brightness: context.watch<SettingProvider>().isDark
            ? Brightness.dark
            : Brightness.light,
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
  late bool isDark = false;

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
    // Provider update UI
    notifyListeners();
  }

  set newColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }

  void setDarkTheme(_isDark) {
    isDark = _isDark;
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
          actions: [
            Switch(
                value: context.watch<SettingProvider>().isDark,
                onChanged: (newValue) {
                  print("In File: main.dart, Line: 95 ${newValue} ");
                  Provider.of<SettingProvider>(context, listen: false)
                      .setDarkTheme(newValue);
                })
          ],
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
              ElevatedButton(
                onPressed: () {
                  context.read<SettingProvider>().newColor = Colors.green;
                },
                child: Text("ChangeColor SET"),
              ),
              ElevatedButton(
                onPressed: () {
                  // context.read<SettingProvider>().newColor = Colors.green;
                  Provider.of<SettingProvider>(context, listen: false)
                      .setDarkTheme(true);
                },
                child: Text("Brightness SET"),
              ),
              ElevatedButton(
                onPressed: () {
                  getIt<AppModel>().incrementCounter();
                },
                child: Text("COUNTER SET GET IT"),
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
