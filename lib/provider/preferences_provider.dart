import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyResataurantActive = false;
  bool get isRestaurantActive => _isDailyResataurantActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantPreferences();
  }

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyResataurantActive = await preferencesHelper.isDailyRemindersActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyReminders(value);
    _getDailyRestaurantPreferences();
  }
}
