import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/authentication/auth_bloc.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:book/presentation/blocs/purchases/purchases_bloc.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/presentation/pages/settings/themes/themes_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              CloseSessionBtn(translations: translations)
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
