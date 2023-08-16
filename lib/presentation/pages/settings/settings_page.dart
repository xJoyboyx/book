import 'package:book/data/models/theme_item.dart';
import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/language/language_selection_page.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceder al estado de LanguageBloc para obtener las traducciones
    final languageState = context.watch<LanguageBloc>().state;
    final translations = languageState is LanguageSelectedState
        ? languageState.translations
        : null;

    // Acceder al estado de ThemeBloc para obtener el tema actual
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
              padding:
                  EdgeInsets.symmetric(vertical: .01.sh, horizontal: .05.sw),
              child: Row(
                children: [
                  Text(
                    translations!
                        .getCopy('configuration', 'select_language')
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: Icon(Icons.language),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => LanguageSelectionPage(),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: .05.sh),
            Text(
              translations!
                  .getCopy('configuration', 'select_themes')
                  .toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: .01.sh),
            Container(
              height: .6.sh,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppThemes.themeIds.length,
                itemBuilder: (context, index) {
                  final themeId = AppThemes.themeIds[index];
                  final themeData = AppThemes.getThemeById(index);
                  final isCurrentTheme = themeState.themeData == themeData;

                  return Padding(
                    padding: EdgeInsets.only(top: .01.sh),
                    child: GestureDetector(
                      onTap: () {
                        print('themeId: ${themeId}');
                        context
                            .read<ThemeBloc>()
                            .add(ThemeChanged(themeId: index));
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/media/theme${index + 1}.gif',
                              width: 1.sw),
                          SizedBox(height: .01.sh),
                          Text(
                            translations!
                                .getCopy('configuration', 'theme${index + 1}')
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
