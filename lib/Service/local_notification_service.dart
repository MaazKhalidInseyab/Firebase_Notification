import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class localNotificationService{
  localNotificationService();
  final Service=FlutterLocalNotificationsPlugin();
  Future<void>initialize()async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher');

    var iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
  }
}