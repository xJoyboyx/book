import 'package:book/data/datasources/book_local_data_source.dart';
import 'package:book/data/models/book.dart';
import 'package:book/data/repositories/book_repository.dart';
import 'package:book/presentation/blocs/language/language_bloc_factory.dart';
import 'package:book/presentation/blocs/theme/theme_bloc_factory.dart';
import 'package:book/presentation/pages/book/book_home_page.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/services/in_app_purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/blocs/language/language_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';

void main() async {
  await initApp();
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  final languageBloc = createLanguageBloc(sharedPreferences);
  final themeBloc = createThemeBloc(sharedPreferences);
  final iapDetails = await fetchIAPDetails();

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
