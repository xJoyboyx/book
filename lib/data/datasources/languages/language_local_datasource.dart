import 'package:book/domain/entities/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Language? getSelectedLanguage();
  void setSelectedLanguage(Language language);
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Language? getSelectedLanguage() {
    final languageCode = sharedPreferences.getString('selected_language');
    print('🌞🌞language code: ${languageCode}');
    if (languageCode != null) {
      return Language(
          code: languageCode, name: "English"); // Esto es solo un ejemplo
    }
    return null;
  }

  @override
  void setSelectedLanguage(Language language) {
    sharedPreferences.setString('selected_language', language.code);
  }
}
