import 'package:flutter/material.dart';

import '../profile/Profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [IconButton(onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ));}, icon: Icon(Icons.notifications))],
    )));
  }
}
