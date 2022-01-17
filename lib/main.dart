import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/app_model.dart';
import 'package:provider_test/change_provider.dart';
import 'package:provider_test/counter.dart';
import 'package:provider_test/locator.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<AppModel>(AppModelImplementation(),
      signalsReady: true);
  setup();
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
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
