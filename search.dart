import 'package:chatapp/constants.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/helper.dart';
import 'package:chatapp/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'conversation.dart';

class searchscreen extends StatefulWidget {
  @override
  _searchscreenState createState() => _searchscreenState();
}
String _myName;
class _searchscreenState extends State<searchscreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch()
  {
    databaseMethods.getUserbyUserName(searchTextEditingController.text).then((value){
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  createchatconversation({String username})
  {
    if(username != constants.myName)
    {
      String chatroomid = getChatRoomId(username, constants.myName);

    List<String> users = [username, constants.myName];
    Map<String, dynamic> chatroomMap = {
      "users" : users,
      "chatroomid" : chatroomid,
    };

    databaseMethods.createconversationroom(chatroomid, chatroomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context) => conversation(chatroomid)
    ));
    }else{
      print("One cannot send messages to itself !!");
    }
  }

  Widget SearchTile({String username, String useremail})
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username,style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20
              ),
              ),
              Text(useremail, style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20
              ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: ()
            {
              createchatconversation(
                username: username
                );
            },
             child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message", style: simpleText(),),
            ),
          )
        ],
      ),
    );
  }

  void initState()
  {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async
  {
    _myName = await Helperfunctions.getUserNamesharedPreference();
    setState(() {
      
    });
  }

  Widget searchlist()
  {
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
          username: searchSnapshot.documents[index].data["name"],
          useremail: searchSnapshot.documents[index].data["email"],
          );
    }) : Container();

    void initState()
    {
       super.initState();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/search.jpg"), 
              fit: BoxFit.cover,
            )
          ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController ,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                      decoration: InputDecoration(
                        hintText: "Search for a username",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    ),
                  GestureDetector(
                    onTap: ()
                    {
                      initiateSearch();
                    },
                      child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images/search_white.png")
                    ),
                  ),
                ],
              ),
            ),
            searchlist(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }