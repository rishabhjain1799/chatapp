import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context)
{
  return AppBar(
    centerTitle: true,
    title: Image.asset("assets/images/namaste.JPG",height: 50,),
    backgroundColor: Colors.red,
  );
}

InputDecoration textformfield(String hintText)
{
  return InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                    )
                )
              );
}

TextStyle simpleText()
{
  return TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
              );
}