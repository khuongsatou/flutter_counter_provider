import 'package:flutter/material.dart';
import 'package:provider_test/main.dart';

abstract class AppModel extends ChangeNotifier {
  void incrementCounter();

  int get counter;
}

class AppModelImplementation extends AppModel {
  int _counter = 0;

  AppModelImplementation() {
    Future.delayed(Duration(seconds: 10))
        .then((value) => getIt.signalReady(this));
  }

  @override
  // TODO: implement counter
  int get counter => _counter;

  @override
  void incrementCounter() {
    // TODO: implement incrementCounter
    _counter++;
    print("In File: app_model.dart, Line: 26 ${_counter} ");
    notifyListeners();
  }
}
