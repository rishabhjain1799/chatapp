import 'package:chatapp/auth.dart';
import 'package:chatapp/chatroom.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/helper.dart';
import 'package:chatapp/widget.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {

  final Function toggle;
  signUp(this.toggle);
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signUp> {

  bool isloading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  final formkey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp()
  {
    if(formkey.currentState.validate())
    {
       Map<String, String> userInfoMap = {
          "name" : usernameTextEditingController.text,
          "email": emailTextEditingController.text,
        };

        Helperfunctions.saveUserEmailsharedPrefernce(emailTextEditingController.text);
        Helperfunctions.saveuserNamesharedPreference(usernameTextEditingController.text);
      setState(() {
        isloading = true;
      });

      authMethods.signUpWithEmailandPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value)
      {
        databaseMethods.uploadUserInfo(userInfoMap);
        Helperfunctions.saveuserLoggedInsharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => chatroom()
        )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isloading ? Container(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
      ) : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 60,
                alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chat.jpg"), 
              fit: BoxFit.cover
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formkey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "This field is Mandatory";
                        }
                        if(value.length < 4)
                        {
                          return "Username must be more  than 4 characters";
                        }
                        else{
                          return null;
                        }
                      },
                  controller: usernameTextEditingController,
                  decoration: textformfield("Username"),
                  style: simpleText(),
                ),

                TextFormField(
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
                  controller: emailTextEditingController,
                  decoration: textformfield("Email"),
                  style: simpleText(),
                ),

                TextFormField(
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
                  controller: passwordTextEditingController,
                  decoration: textformfield("Password"),
                  style: simpleText(),
                  obscureText: true,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 45,
              ),

              GestureDetector(
                onTap: ()
                {
                  signMeUp();
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
                  child: Text("Sign In", style: TextStyle(
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
    );
  }
}