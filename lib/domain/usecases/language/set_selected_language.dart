import 'package:book/data/repositories/language/language_repository.dart';
import 'package:book/domain/entities/language.dart';

class SetSelectedLanguage {
  final LanguageRepository repository;

  SetSelectedLanguage(this.repository);

  Future<void> call(Language language) async {
    return repository.setSelectedLanguage(language);
  }
}
