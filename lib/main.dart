import 'dart:async';
import 'package:book/data/datasources/book_local_data_source.dart';
import 'package:book/data/datasources/http_client_impl.dart';
import 'package:book/data/models/book.dart';
import 'package:book/data/repositories/book_repository.dart';
import 'package:book/data/repositories/user_repository_impl.dart';
import 'package:book/data/services/user_service.dart';
import 'package:book/domain/entities/language.dart';
import 'package:book/domain/usecases/session/signin/sign_in_usecase.dart';
import 'package:book/firebase_options.dart';
import 'package:book/presentation/blocs/language/language_bloc_factory.dart';
import 'package:book/presentation/blocs/purchases_bloc/purchases_bloc.dart';
import 'package:book/presentation/blocs/theme/theme_bloc_factory.dart';
import 'package:book/presentation/pages/book/book_home_page.dart';
import 'package:book/presentation/pages/book/chapter_content_page.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/presentation/pages/login/login_screen.dart';
import 'package:book/services/in_app_purchase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/blocs/authentication/auth_bloc.dart';
import 'presentation/blocs/language/language_bloc.dart';
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
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _purchasePending = false;
  final httpClient = HttpClientImpl();
  final userService = UserService(httpClient: httpClient);
  final googleSignIn = GoogleSignIn();

  final userRepository = UserRepositoryImpl(
      sharedPreferences: sharedPreferences,
      googleSignIn: googleSignIn,
      userService: userService);
  final signInUseCase = SignInUseCase(userRepository: userRepository);
  final authBloc = AuthBloc(signInUseCase: signInUseCase);

  final iapDetails = await fetchIAPDetails();
  final purchaseBloc = PurchaseBloc(iapDetails: iapDetails);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: languageBloc),
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<PurchaseBloc>.value(value: purchaseBloc),
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
                          if (authState == Authenticated) {
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
            _checkEmail(context);
            return BookHomePage(book: snapshot.data!);
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}

Future<void> _checkEmail(context) async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('user_email');

  if (email == null || email.isEmpty) {
    _showEmailDialog(context);
  }
}

Future<void> _showEmailDialog(context) async {
  final TextEditingController emailController = TextEditingController();
  final languageState = context.watch<LanguageBloc>().state;
  final translations = languageState is LanguageSelectedState
      ? languageState.translations
      : null;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium, // Estilo base
              children: interpretText(
                  translations!.getCopy('configuration', 'email-dt'),
                  0.1,
                  context),
            )),
        content: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: translations.getCopy('configuration', 'email-ph'),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium, // Estilo base
                  children: interpretText(
                      translations.getCopy('configuration', 'email-save'),
                      0.1,
                      context),
                )),
            onPressed: () async {
              final email = emailController.text;
              if (email.isNotEmpty) {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('user_email', email);
                Navigator.of(context).pop();
              } else {
                // Puedes mostrar un mensaje de error o hacer algo más aquí.
              }
            },
          ),
        ],
      );
    },
  );
}
