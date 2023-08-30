import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test4/Ui/Home/HomeScreen.dart';
import 'package:test4/Ui/profile/Profile.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void RequestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    }
  }

  Future<String?> GetDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("This is handleMessage" + message.data['type']);
    // if (message.data['type'] == 'home') {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ProfileScreen(),
    //     ));
    //  print("handle message ok");
    //  } else {
    //    print("else running");
    //  }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ));
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      print("Title:" + message.notification!.title.toString());
      print("Message:" + message.notification!.body.toString());
      //   print("Payload" + message.data['id']);

      initLocalNotifications(context, message);

      showNotifications(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    //INSTANCE FOR NOTIFICATION CHANNEL
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max);

    //INSTANCE FOR ADNROID NOTIFICATIONDETAILS
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            icon: '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

//INSTANCE FOR IOS NOTIFICATIONDETAILS
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    //COMMON INSTANCE FOR NOTIFICATION DETAILS ANDROID + IOS
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }
}
