

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications{

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init()async
  {

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload)=>null,);
    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux,);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => null,
    );

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
  }


  static Future showSimpleNotification({
  required String title,
  required String body,
  required String payload,})async {

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'your channel id',
       'your channel name',
        channelDescription: 'your channel description',
        icon: '@mipmap/launcher_icon',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),

        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails( android: androidNotificationDetails );

    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }


  }