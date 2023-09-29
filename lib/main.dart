import 'dart:async';
import 'package:book/data/datasources/book_local_data_source.dart';
import 'package:book/data/datasources/http_client_impl.dart';
import 'package:book/data/models/book.dart';
import 'package:book/data/repositories/book_repository.dart';
import 'package:book/data/repositories/transaction_repository_impl.dart';
import 'package:book/data/repositories/user_repository_impl.dart';
import 'package:book/data/services/transactions_service.dart';
import 'package:book/data/services/user_service.dart';
import 'package:book/domain/entities/language.dart';
import 'package:book/domain/repositories/transaction_repository.dart';
import 'package:book/domain/usecases/session/signin/sign_in_usecase.dart';
import 'package:book/domain/usecases/transactions/transactions_usecase.dart';
import 'package:book/firebase_options.dart';
import 'package:book/presentation/blocs/language/language_bloc_factory.dart';
import 'package:book/presentation/blocs/theme/theme_bloc_factory.dart';
import 'package:book/presentation/pages/book/book_home_page.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/presentation/pages/login/login_screen.dart';
import 'package:book/services/in_app_purchase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/blocs/authentication/auth_bloc.dart';
import 'presentation/blocs/language/language_bloc.dart';
import 'presentation/blocs/marketplace/marketplace_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';

void main() async {
  await initApp();
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final languageBloc = createLanguageBloc(sharedPreferences);
  final themeBloc = createThemeBloc(sharedPreferences);

  final httpClient = HttpClientImpl();
  final userService =
      UserService(httpClient: httpClient, sharedPreferences: sharedPreferences);
  final googleSignIn = GoogleSignIn();

  final userRepository = UserRepositoryImpl(
      sharedPreferences: sharedPreferences,
      googleSignIn: googleSignIn,
      userService: userService);

  final signInUseCase = SignInUseCase(userRepository: userRepository);
  final authBloc = AuthBloc(signInUseCase: signInUseCase)..add(AutoLogin());

  final TransactionsService transactionsService = TransactionsService(
      httpClient: httpClient, sharedPreferences: sharedPreferences);
  final TransactionRepository transactionRepository =
      TransactionRepositoryImpl(transactionsService: transactionsService);
  final transactionUseCase =
      TransactionsUseCase(transactionRepository: transactionRepository);
  final iapDetails = await fetchIAPDetails();
  final purchaseBloc = MarketPlaceBloc(
      iapDetails: iapDetails,
      transactionsUseCase: transactionUseCase,
      sharedPreferences: sharedPreferences);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: languageBloc),
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<MarketPlaceBloc>.value(value: purchaseBloc),
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
                      return BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          print('AuthState: ${authState}');
                          if (authState is Authenticated) {
                            context
                                .read<MarketPlaceBloc>()
                                .add(LoadPurchases());
                            return BookBuilder(
                              bookRepository: bookRepository,
                              language: state.language,
                            );
                          } else {
                            return LoginScreen();
                          }
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

class BookBuilder extends StatelessWidget {
  const BookBuilder({
    super.key,
    required this.bookRepository,
    required this.language,
  });
  final Language language;
  final BookRepositoryImpl bookRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book>(
      future: bookRepository.loadBookBasedOnLanguage(language.code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
}
