import 'package:provider_test/domain/meme_controller.dart';
import 'package:provider_test/domain/models/meme.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class MemeRepo {
  Future<Meme> getMeme() async {
    Uri uri = Uri.parse("https://some-random-api.ml/meme");
    var response = await http.get(uri);
    print("In File: meme_responsitory.dart, Line: 10 ${response.body} ");
    Map<String, dynamic> singleMemeJson = convert.jsonDecode(response.body);
    print("In File: meme_responsitory.dart, Line: 12 ${singleMemeJson} ");
    return Meme.fromJson(singleMemeJson);
  }
}
