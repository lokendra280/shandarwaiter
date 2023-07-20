import 'dart:io';
import 'package:efood_table_booking/controller/localization_controller.dart';
import 'package:efood_table_booking/controller/theme_controller.dart';
import 'package:efood_table_booking/helper/notification_helper.dart';
import 'package:efood_table_booking/helper/route_helper.dart';
import 'package:efood_table_booking/theme/dark_theme.dart';
import 'package:efood_table_booking/theme/light_theme.dart';
import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/util/messages.dart';
import 'package:efood_table_booking/view/screens/root/not_found_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (!GetPlatform.isWeb) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyAUrJA0SxAXbcTvj9eAeZaP9D7RjELmGBo',
            appId: '1:360097262724:android:8705a2407d9cabb1ca26d1',
            messagingSenderId: '360097262724',
            projectId: 'test-2674b',
            storageBucket: 'test-2674b.appspot.com',
            ));
  }
  Map<String, Map<String, String>> _languages = await di.init();

  int? _orderID;
  try {
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      _orderID = remoteMessage.notification?.titleLocKey != null
          ? int.tryParse(remoteMessage.notification!.titleLocKey!) ?? null
          : null;
    }
  } catch (e) {}

  runApp(MyApp(languages: _languages, orderID: _orderID));
}
Future<void> showNotification() async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    sound: const RawResourceAndroidNotificationSound('notification'),
     autoCancel: false,
     enableVibration: true,
     
  );

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await FlutterLocalNotificationsPlugin().show(
    2,
    'Notification Title',
    'Notification Body',
    platformChannelSpecifics,
    payload: 'Custom_Sound',

  );
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final int? orderID;
  MyApp({@required this.languages, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetMaterialApp(
              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark : light,
              locale: localizeController.locale,
              translations: Messages(languages: languages!),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),
              initialRoute: RouteHelper.splash,
              getPages: RouteHelper.routes,
              unknownRoute: GetPage(name: '/', page: () => NotFoundScreen()),
              defaultTransition: Transition.topLevel,
              transitionDuration: Duration(milliseconds: 500),
              scrollBehavior: MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
              ),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
