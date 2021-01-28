import 'package:chatapp/auth.dart';
import 'package:chatapp/authenticate.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/helper.dart';
import 'package:chatapp/search.dart';
import 'package:chatapp/widget.dart';
import 'package:flutter/material.dart';

class chatroom extends StatefulWidget {
  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatroomStream;

  Widget chatroomList()
  {
    return StreamBuilder(
      stream: chatroomStream,
      builder: (context, snapshots)
      {
        return snapshots.hasData ? ListView.builder(
          itemCount: snapshots.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index)
          {
            return ChatRoomTile(
              username : snapshots.data.documents[index].data['chatroomid']
            );
          }) : Container();
      },
      );
  }
  @override

  void initState()
  {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async
  {
    constants.myName = await Helperfunctions.getUserNamesharedPreference();
    databaseMethods.getchatrooms(constants.myName).then((value)
    {
      setState(() {
         chatroomStream = value;
      });
    });
    setState(() {
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    centerTitle: true,
    title: Image.asset("assets/images/namaste.JPG",height: 50,),
    backgroundColor: Colors.red,
    actions: <Widget>[
      GestureDetector(
        onTap: ()
        {
          authMethods.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => authenticate()
          )
          );
        },
              child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.https)
          ),
      )
    ],
  ),

  body: Container(
    decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blank.jpg"), 
              fit: BoxFit.cover,
            )
          ),
  ),

  floatingActionButton: FloatingActionButton(onPressed: ()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => searchscreen()
    )
    );
  },
  child: Icon(Icons.search),
  ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  ChatRoomTile({this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Text("${username.substring(0,1)}"),
        ),
        SizedBox(
          width: 8,
        ),
        Text(username, style: simpleText(),)
      ],
      )
    );
  }
}