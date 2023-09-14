import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
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

    return Scaffold(
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
            Padding(
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => LanguageSelectionPage(),
                  );
                },
              ),
            ),
            ThemesBottomSheet(
                translations: translations, themeState: themeState),
          ],
        ),
      ),
    );
  }
}
