import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/settings/themes/themes_bottom_sheet.dart';
import 'package:book/presentation/widgets/media-widgets/image_builder.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({
    super.key,
    required this.widget,
  });

  final ThemesBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppThemes.themeIds.length,
        itemBuilder: (context, index) {
          final themeId = AppThemes.themeIds[index];
          final themeData = AppThemes.getThemeById(index);
          final isCurrentTheme = widget.themeState.themeData == themeData;

          return Padding(
            padding: EdgeInsets.only(top: .02.sh),
            child: GestureDetector(
              onTap: () {
                print('theme: ${themeId}');
                context.read<ThemeBloc>().add(ThemeChanged(themeId: index));
              },
              child: Column(
                children: [
                  ImageBuilder(
                    imageName: 'theme',
                    themeId: (index + 1).toString(),
                    width: 1.sw,
                  ),
                  SizedBox(height: .01.sh),
                  Text(
                    widget.translations!
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
    );
  }
}
