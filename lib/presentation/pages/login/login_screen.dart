import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/authentication/auth_bloc.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final translations = languageState is LanguageSelectedState
        ? languageState.translations
        : null;
    return Scaffold(
      body: Center(
        child: Container(
          color: AppThemes.backgroundColorTheme1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: .1.sh),
                  child: Image.asset(
                    'assets/media/theme1/portrait.png',
                    height: .4.sh,
                  ),
                ),
                SizedBox(height: .05.sh),
                Text(
                  translations!
                      .getCopy('session', 'welcome')
                      .toUpperCase()
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppThemes.displayMedium1.copyWith(fontSize: 26),
                ),
                Spacer(),
                GoogleLoginBtn(translations: translations),
                SizedBox(height: .01.sh),
                AppleLoginBttn(translations: translations),
                SizedBox(height: .1.sh),
                TermsAndConditionButton(translations: translations),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginBtn extends StatelessWidget {
  const GoogleLoginBtn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInWithGoogle());
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(AppThemes.backgroundColorTheme1),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      icon: Image.asset('assets/media/session/google_logo.png', height: 18.0),
      label: Text(
        translations!.getCopy('session', 'login_google'),
        style: AppThemes.displayMedium1,
      ),
    );
  }
}

class AppleLoginBttn extends StatelessWidget {
  const AppleLoginBttn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInWithApple());
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(AppThemes.backgroundColorTheme1),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      icon: Image.asset('assets/media/session/apple_logo.png', height: 18.0),
      label: Text(
        translations!.getCopy('session', 'login_apple'),
        style: AppThemes.displayMedium1,
      ),
    );
  }
}

class TermsAndConditionButton extends StatelessWidget {
  const TermsAndConditionButton({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: .02.sh),
      child: TextButton(
        onPressed: () async {
          Uri url = Uri.parse('https://spiraldimensions.com/#/terms');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw 'No se pudo abrir la URL $url';
          }
        },
        child: Text(
          translations!.getCopy('session', 'terms_and_conditions'),
          style: AppThemes.displayMedium1
              .copyWith(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
