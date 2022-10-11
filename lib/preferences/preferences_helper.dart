import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyReminders = 'DAILY_REMINDERS';
  static const darkTheme = 'DARK_THEME';

  // * menyimpan dan membaca data dari shared_preferences
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  // * mengatur dan menyimpan data dari shceduling daily restaurant
  Future<bool> get isDailyRemindersActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminders) ?? false;
  }

  void setDailyReminders(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminders, value);
  }
}
