import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test4/Service/Notification_service.dart';
import 'Ui/Home/HomeScreen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await  Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
   runApp(const MyApp());

}
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
await Firebase.initializeApp();
print(message.notification!.title.toString());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notifier=NotificationService();
  @override

  void initState() {
    notifier.RequestNotificationPermission();
    notifier.GetDeviceToken().then((value) => debugPrint('Device Token: $value'));

    super.initState();
}
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

