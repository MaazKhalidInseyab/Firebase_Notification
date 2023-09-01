import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test4/Service/Notification_service.dart';

import '../profile/Profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService service = NotificationService();
  String? token = "";
  String? token2 = "";

  void getToken() async {
    token = await NotificationService().GetDeviceToken() as String?;
    setState(() {
      token2 = token;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    service.firebaseInit(context);


    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              getToken();
            },
            icon: Icon(Icons.notifications)),
        SelectableText(token2.toString())
      ],
    )));
  }






}
