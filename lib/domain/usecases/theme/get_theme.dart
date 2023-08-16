import 'package:shared_preferences/shared_preferences.dart';

class GetSelectedTheme {
  final SharedPreferences sharedPreferences;

  GetSelectedTheme(this.sharedPreferences);

  int? call() {
    return sharedPreferences.getInt('selected_theme_id');
  }
}
