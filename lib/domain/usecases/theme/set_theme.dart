import 'package:shared_preferences/shared_preferences.dart';

class SetSelectedTheme {
  final SharedPreferences sharedPreferences;

  SetSelectedTheme(this.sharedPreferences);

  Future<void> call(int themeId) async {
    await sharedPreferences.setInt('selected_theme_id', themeId);
  }
}
