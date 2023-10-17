import 'package:book/data/datasources/languages/language_local_datasource.dart';
import 'package:book/data/repositories/language/language_repository_impl.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

LanguageBloc createLanguageBloc(SharedPreferences sharedPreferences) {
  final localDataSource =
      LanguageLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final repository = LanguageRepositoryImpl(localDataSource: localDataSource);
  return LanguageBloc(repository: repository)..add(AppStarted());
}
