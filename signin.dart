import 'package:chatapp/auth.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chatroom.dart';
import 'helper.dart';

class Signin extends StatefulWidget {

  final Function toggle;
  Signin(this.toggle);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  QuerySnapshot snapshotUserInfo;
  final formkey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isloading = false;
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signIn()
  {
    if(formkey.currentState.validate())
    {
      Helperfunctions.saveUserEmailsharedPrefernce(emailTextEditingController.text);
      databaseMethods.getUserbyUserEmail(emailTextEditingController.text).then((value)
      {
        snapshotUserInfo = value;
        Helperfunctions.saveuserNamesharedPreference(snapshotUserInfo.documents[0].data["name"]);
      });

      setState(() {
        isloading = true;
      });

      authMethods.signInwithEmailandpassword(emailTextEditingController.text, passwordTextEditingController.text).then((value)
      {
        if(value != null)
        {
          Helperfunctions.saveuserLoggedInsharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => chatroom()
        )
        );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 60,
                alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sign.jpg"), 
              fit: BoxFit.cover
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formkey,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: emailTextEditingController,
                  decoration: textformfield("Email"),
                  style: simpleText(),
                  validator: (value)
                  {
                    if(value.isEmpty)
                    {
                      return "This Field Is Madatory";
                    }
                    if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                          return 'Email Address not Valid';
                        }
                        else{
                          return null;
                        }
                  },
                ),

                TextFormField(
                  controller: passwordTextEditingController,
                  decoration: textformfield("Password"),
                  style: simpleText(),
                  obscureText: true,
                  validator: (value)
                  {
                    if(value.isEmpty)
                    {
                      return "Please Set a Password";
                    }
                    if(value.length < 6)
                    {
                      return "The length should be more than 5";
                    }
                    else{
                      return null;
                    }
                  },
                    ),

                SizedBox(
                  height: 8,
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Forgot Password ?", style: simpleText(),),
                ),
                ),

                SizedBox(
                  height: 50,
                ),

                GestureDetector(
                  onTap: ()
                  {
                    signIn();
                  },
                    child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    ),
                  ),
                ),

                 SizedBox(
                  height: 20,
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      Text("------- OR -------", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      )
                    ],
                  )
                ),

                SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  onTap: ()
                  {
                    widget.toggle();
                  },
                    child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign Up", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}