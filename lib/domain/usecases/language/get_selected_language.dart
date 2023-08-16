import 'package:book/data/repositories/language/language_repository.dart';
import 'package:book/domain/entities/language.dart';

class GetSelectedLanguage {
  final LanguageRepository repository;

  GetSelectedLanguage(this.repository);

  Future<Language?> call() async {
    return repository.getSelectedLanguage();
  }
}
