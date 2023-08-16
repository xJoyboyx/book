import 'dart:convert';

import 'package:book/data/models/book.dart';
import 'package:flutter/services.dart';

class BookLocalDataSource {
  Future<Book> loadBookBasedOnLanguage(String languageCode) async {
    final jsonString =
        await rootBundle.loadString('assets/books/$languageCode.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return Book.fromJson(jsonData);
  }
}
