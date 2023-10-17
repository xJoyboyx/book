import 'dart:io';

import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/authentication/auth_bloc.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:book/presentation/blocs/purchases/purchases_bloc.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/presentation/pages/settings/themes/themes_bottom_sheet.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final translations = languageState is LanguageSelectedState
        ? languageState.translations
        : null;

    final themeState = context.watch<ThemeBloc>().state;

    return BlocProvider(
      create: (context) => PurchaseBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            translations!.getCopy('configuration', 'header'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              SelectLanguageBtn(translations: translations),
              SelectThemeButton(
                  translations: translations, themeState: themeState),
              CloseSessionBtn(translations: translations),
              Spacer(),
              if (Platform.isIOS)
                Padding(
                  padding: EdgeInsets.only(bottom: .03.sh),
                  child: TextButton(
                    onPressed: () async {
                      Uri url =
                          Uri.parse('https://spiraldimensions.com/#/terms');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'No se pudo abrir la URL $url';
                      }
                    },
                    child: Text(
                      'APPLE LICENSED APPLICATION END USER LICENSE AGREEMENT (EULA)',
                      style: AppThemes.displayMedium1
                          .copyWith(decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(bottom: .03.sh),
                child: TextButton(
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            translations!.getCopy(
                                'configuration', 'confirmation-delete-title'),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          content: Text(
                              translations!.getCopy('configuration',
                                  'confirmation-delete-description'),
                              style: Theme.of(context).textTheme.bodyMedium),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                translations!.getCopy(
                                    'configuration', 'cancel-delete-btn'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Retorna false al cerrar el cuadro de diálogo
                              },
                            ),
                            TextButton(
                              child: Text(
                                translations!.getCopy(
                                    'configuration', 'confirmation-delete-btn'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Retorna true al cerrar el cuadro de diálogo
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true) {
                      context.read<AuthBloc>().add(DeleteAcount());
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    translations!.getCopy('configuration', 'delete-account'),
                    style: AppThemes.displayMedium1.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppThemes.dimensionsColorsTheme1[1]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectThemeButton extends StatelessWidget {
  const SelectThemeButton({
    super.key,
    required this.translations,
    required this.themeState,
  });

  final Translations? translations;
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return ThemesBottomSheet(
        translations: translations, themeState: themeState);
  }
}

class SelectLanguageBtn extends StatelessWidget {
  const SelectLanguageBtn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .02.sh),
      child: ListTile(
        title: Text(
          translations!
              .getCopy('configuration', 'select_language')
              .toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => LanguageSelectionPage(),
          );
        },
      ),
    );
  }
}

class CloseSessionBtn extends StatelessWidget {
  const CloseSessionBtn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .02.sh),
      child: ListTile(
        title: Text(
          translations!.getCopy('configuration', 'logout').toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          context.read<AuthBloc>().add(SignOut());
          Navigator.pop(context);
        },
      ),
    );
  }
}
