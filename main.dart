import 'package:chatapp/authenticate.dart';
import 'package:chatapp/chatroom.dart';
import 'package:chatapp/helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userLoggedIn = false;
  @override

  void initState()
  {
    getLoggedinState();
    super.initState();
  }

  getLoggedinState() async
  {
    await Helperfunctions.getUserLoggedInsharedPreference().then((value)
    {
      setState(() {
        userLoggedIn = value;
      });
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userLoggedIn != null ?  userLoggedIn ? chatroom() : authenticate()
          : Container(
        child: Center(
          child: authenticate(),
    ),
    ),
    );
  }
}