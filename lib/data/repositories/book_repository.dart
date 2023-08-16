import 'package:book/data/datasources/book_local_data_source.dart';
import 'package:book/data/models/book.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({required this.localDataSource});

  @override
  Future<Book> loadBookBasedOnLanguage(String languageCode) {
    return localDataSource.loadBookBasedOnLanguage(languageCode);
  }
}

abstract class BookRepository {
  Future<Book> loadBookBasedOnLanguage(String languageCode);
}
