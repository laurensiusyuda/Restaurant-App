import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_page_provider.dart';
import 'package:restaurant_app/provider/search_list_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'package:restaurant_app/preferences/preferences_helper.dart';

import 'package:restaurant_app/provider/list_page_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

import 'package:restaurant_app/ui/homepage.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/ui/description.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/detail_menu.dart';

import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurant Detail',
            theme: provider.themeData,
            // * mengembalikan widget cupertino themes data digunakan untuk komponen cupertino
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              SearchRestaurant.routeName: (context) => const SearchRestaurant(),
              DetailRestaurant.routeName: (context) => DetailRestaurant(
                    id: ModalRoute.of(context)!.settings.arguments == null
                        ? 'null'
                        : ModalRoute.of(context)!.settings.arguments as dynamic,
                  ),
              DescriptionRestaurant.routeName: (context) =>
                  DescriptionRestaurant(
                      id: ModalRoute.of(context)!.settings.arguments == null
                          ? 'null'
                          : ModalRoute.of(context)!.settings.arguments
                              as dynamic),
              MenuPageList.routeName: (context) => MenuPageList(
                  id: ModalRoute.of(context)!.settings.arguments == null
                      ? 'null'
                      : ModalRoute.of(context)!.settings.arguments as dynamic),
            },
          );
        },
      ),
    );
  } // build
}
