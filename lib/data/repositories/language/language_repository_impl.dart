import 'package:book/data/datasources/languages/language_local_datasource.dart';
import 'package:book/data/repositories/language/language_repository.dart';
import 'package:book/domain/entities/language.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImpl({required this.localDataSource});

  @override
  Language? getSelectedLanguage() {
    return localDataSource.getSelectedLanguage();
  }

  @override
  void setSelectedLanguage(Language language) {
    localDataSource.setSelectedLanguage(language);
  }
}
