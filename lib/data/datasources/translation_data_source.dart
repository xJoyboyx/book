import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:book/data/models/translations.dart';

class TranslationDataSource {
  Future<Translations> loadTranslations(String languageCode) async {
    String jsonString =
        await rootBundle.loadString('assets/copys/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Translations(jsonMap);
  }
}
