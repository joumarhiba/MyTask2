import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_mobile/conf/db.dart';
import 'package:first_mobile/services/theme_service.dart';
import 'package:first_mobile/ui/home_page.dart';
import 'package:first_mobile/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHelper.initDb();
  await GetStorage.init();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
       channelKey: 'basic_channel',
       channelName: 'Basic notif', 
       channelDescription: 'Notification channel test')
    ],
    debug: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: HomePage(),
    );
  }
}
