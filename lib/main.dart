import 'dart:convert';

import 'package:book/data/datasources/book_local_data_source.dart';
import 'package:book/data/datasources/languages/language_local_datasource.dart';
import 'package:book/data/models/book.dart';
import 'package:book/data/models/translations.dart';
import 'package:book/data/repositories/book_repository.dart';
import 'package:book/data/repositories/language/language_repository_impl.dart';
import 'package:book/domain/usecases/theme/get_theme.dart';
import 'package:book/domain/usecases/theme/set_theme.dart';
import 'package:book/presentation/pages/book/book_home_page.dart';
import 'package:book/presentation/pages/book/book_reading_page.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/blocs/language/language_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final LanguageLocalDataSource localDataSource =
      LanguageLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final LanguageRepositoryImpl repository =
      LanguageRepositoryImpl(localDataSource: localDataSource);
  final setSelectedTheme = SetSelectedTheme(sharedPreferences);
  final getSelectedTheme = GetSelectedTheme(sharedPreferences);

  final languageBloc = LanguageBloc(repository: repository)..add(AppStarted());
  final themeBloc = ThemeBloc(
      setSelectedTheme: setSelectedTheme, getSelectedTheme: getSelectedTheme)
    ..add(LoadThemeEvent());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: languageBloc),
        BlocProvider<ThemeBloc>.value(value: themeBloc),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: 'Book App',
                theme: themeState.themeData,
                home: BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    if (state is LanguageSelectedState) {
                      final bookRepository = BookRepositoryImpl(
                          localDataSource: BookLocalDataSource());
                      return FutureBuilder<Book>(
                        future: bookRepository
                            .loadBookBasedOnLanguage(state.language.code),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Container(); // Puedes crear una página de error o mostrar un widget de error aquí.
                            }
                            if (snapshot.hasData && snapshot.data != null) {
                              return BookHomePage(book: snapshot.data!);
                            }
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    }
                    return LanguageSelectionPage();
                  },
                ),
              );
            },
          );
        });
  }
}

Future<Translations> loadTranslations(String languageCode) async {
  String jsonString =
      await rootBundle.loadString('assets/copys/$languageCode.json');
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  return Translations(jsonMap);
}
