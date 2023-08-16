import 'package:flutter/material.dart';

class AppThemes {
  static const themeIds = ['original', 'pixeles'];

  //#region THEME 1
  //#region THEME 1 COLORS
  static const primaryColorTheme1 = Colors.white;
  static const backgroundColorTheme1 = Color.fromRGBO(32, 30, 30, 1);
  static const accentColorTheme1 = Color.fromRGBO(149, 149, 149, 1);
  static const dimensionsColorsTheme1 = [
    Color.fromRGBO(214, 207, 190, 1),
    Color.fromRGBO(217, 85, 85, 1),
    Color.fromRGBO(217, 148, 85, 1),
    Color.fromRGBO(217, 211, 85, 1),
    Color.fromRGBO(119, 217, 85, 1),
    Color.fromRGBO(85, 217, 185, 1),
    Color.fromRGBO(85, 185, 217, 1),
    Color.fromRGBO(85, 114, 217, 1),
    Color.fromRGBO(111, 85, 217, 1),
    Color.fromRGBO(159, 85, 217, 1),
    Color.fromRGBO(0, 0, 0, 1)
  ];

  //#endregion
  //region THEME 1 COLOR SCHEME
  static const ColorScheme theme1ColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black54,
      secondary: Color.fromRGBO(214, 214, 214, 100),
      onSecondary: Colors.black87,
      error: Colors.redAccent,
      onError: Colors.black87,
      background: backgroundColorTheme1,
      onBackground: Color.fromRGBO(217, 217, 217, 1),
      surface: Color.fromRGBO(149, 149, 149, 100),
      onSurface: Color.fromRGBO(190, 190, 190, 100));
  //#endregion
  //#region THEME 1 TEXT THEME
  static const TextTheme textTheme1 = TextTheme(
    titleLarge: titleLarge1,
    titleMedium: titleLMedium1,
    displayLarge: displayLarge1,
    displayMedium: displayMedium1,
    bodyLarge: bodyLarge1,
    bodyMedium: bodyMedium1,
    headlineMedium: headLineMedium1,
  );
  //#endregion
  //#region THEME 1 TEXT_STYLES
  static const TextStyle headLineMedium1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w800, fontFamily: 'Inter');
  static const TextStyle displayLarge1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w200,
    letterSpacing: 10.0,
    fontFamily: 'Inter',
  );
  static const TextStyle displayMedium1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 5.0,
      fontFamily: 'Inter');
  static const TextStyle titleLarge1 = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w900,
      color: primaryColorTheme1,
      fontFamily: 'Inter');
  static const TextStyle titleLMedium1 = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: primaryColorTheme1,
      fontFamily: 'Inter');
  static const TextStyle bodyMedium1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Inter');
  static const TextStyle bodyLarge1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Inter');

  //#endregion
  static final ThemeData theme1 = ThemeData(
      textTheme: textTheme1,
      colorScheme: theme1ColorScheme,
      fontFamily: 'Inter');
  //#endregion

  //#region THEME 2
  //#region THEME 2 COLORS
  static const primaryColorTheme2 = Color.fromRGBO(214, 207, 190, 1);
  static const backgroundColorTheme2 = Color.fromRGBO(32, 30, 30, 1);
  static const accentColorTheme2 = Color.fromRGBO(149, 149, 149, 1);
  static const dimensionsColorsTheme2 = [
    Color.fromRGBO(214, 207, 190, 1),
    Color.fromRGBO(217, 85, 85, 1),
    Color.fromRGBO(217, 148, 85, 1),
    Color.fromRGBO(217, 211, 85, 1),
    Color.fromRGBO(119, 217, 85, 1),
    Color.fromRGBO(85, 217, 185, 1),
    Color.fromRGBO(85, 185, 217, 1),
    Color.fromRGBO(85, 114, 217, 1),
    Color.fromRGBO(111, 85, 217, 1),
    Color.fromRGBO(159, 85, 217, 1),
    Color.fromRGBO(0, 0, 0, 1)
  ];

  //#endregion
  //region THEME 1 COLOR SCHEME
  static const ColorScheme theme2ColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black54,
      secondary: Color.fromRGBO(214, 214, 214, 100),
      onSecondary: Colors.black87,
      error: Colors.redAccent,
      onError: Colors.black87,
      background: backgroundColorTheme1,
      onBackground: Color.fromRGBO(217, 217, 217, 1),
      surface: Color.fromRGBO(149, 149, 149, 100),
      onSurface: Color.fromRGBO(190, 190, 190, 100));
  //#endregion
  //#region THEME 1 TEXT THEME
  static const TextTheme textTheme2 = TextTheme(
    titleLarge: titleLarge1,
    titleMedium: titleLMedium1,
    displayLarge: displayLarge1,
    displayMedium: displayMedium1,
    bodyLarge: bodyLarge1,
    bodyMedium: bodyMedium1,
    headlineMedium: headLineMedium1,
  );
  //#endregion
  //#region THEME 1 TEXT_STYLES
  static const TextStyle headLineMedium2 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
  static const TextStyle displayLarge2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w200,
    letterSpacing: 10.0,
  );
  static const TextStyle displayMedium2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 5.0,
  );
  static const TextStyle titleLarge2 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: primaryColorTheme1,
  );
  static const TextStyle titleLMedium2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: primaryColorTheme1,
  );
  static const TextStyle bodyMedium2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyLarge2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  //#endregion
  static final ThemeData theme2 = ThemeData(
    textTheme: textTheme1,
    colorScheme: theme1ColorScheme,
  );
//#endregion

  static ThemeData getThemeById(int id) {
    switch (id) {
      case 1:
        return theme1;
      case 2:
        return theme2;
      default:
        return theme1; // Retorna el tema por defecto si el id no coincide
    }
  }
}
