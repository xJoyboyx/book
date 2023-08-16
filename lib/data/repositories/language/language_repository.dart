import 'package:book/domain/entities/language.dart';

abstract class LanguageRepository {
  Language? getSelectedLanguage();
  void setSelectedLanguage(Language language);
}
