import 'package:book/domain/usecases/theme/get_theme.dart';
import 'package:book/domain/usecases/theme/set_theme.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeBloc createThemeBloc(SharedPreferences sharedPreferences) {
  final setSelectedTheme = SetSelectedTheme(sharedPreferences);
  final getSelectedTheme = GetSelectedTheme(sharedPreferences);
  return ThemeBloc(
      setSelectedTheme: setSelectedTheme, getSelectedTheme: getSelectedTheme)
    ..add(LoadThemeEvent());
}
