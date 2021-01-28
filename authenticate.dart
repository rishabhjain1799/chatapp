import 'package:chatapp/signin.dart';
import 'package:chatapp/signup.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  bool showsignin = true;

  void toggleview()
  {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showsignin)
    {
      return Signin(toggleview);
    }
    else{
      return signUp(toggleview);
    }
  }
}