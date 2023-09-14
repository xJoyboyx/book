import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/settings/themes/theme_selection.dart';
import 'package:flutter/material.dart';

class ThemesBottomSheet extends StatefulWidget {
  const ThemesBottomSheet({
    super.key,
    required this.translations,
    required this.themeState,
  });

  final Translations? translations;
  final ThemeState themeState;

  @override
  State<ThemesBottomSheet> createState() => _ThemesBottomSheetState();
}

class _ThemesBottomSheetState extends State<ThemesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.translations!
            .getCopy('configuration', 'select_themes')
            .toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          builder: (context) {
            return ThemeSelection(
              widget: widget,
            );
          },
        );
      },
    );
  }
}
