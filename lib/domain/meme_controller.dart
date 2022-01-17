import 'package:flutter/material.dart';
import 'package:provider_test/domain/models/meme.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:provider_test/locator.dart';
import 'package:provider_test/responsitory/meme_responsitory.dart';

abstract class AppModelNew extends ChangeNotifier {
  Future<Meme> getNextMeme();
}

class MemeDomainController extends AppModelNew {
  MemeDomainController() {
    Future.delayed(Duration(seconds: 2))
        .then((value) => locator.signalReady(this));
  }

  @override
  Future<Meme> getNextMeme() async {
    return locator.get<MemeRepo>().getMeme();
  }
}
