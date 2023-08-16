import 'package:book/data/models/book.dart';
import 'package:book/data/repositories/book_repository.dart';

class GetBookForLanguage {
  final BookRepository repository;

  GetBookForLanguage(this.repository);

  Future<Book> call(String languageCode) {
    return repository.loadBookBasedOnLanguage(languageCode);
  }
}
