import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserbyUserName(String username)async
  {
    return await Firestore.instance.collection("users").where("name", isEqualTo: username).getDocuments();
  }

  getUserbyUserEmail(String useremail)async
  {
    return await Firestore.instance.collection("users").where("email", isEqualTo: useremail).getDocuments();
  }

  uploadUserInfo(userMap)
  {
    Firestore.instance.collection("users").add(userMap).catchError((e)
    {
      print(e.toString());
    });
  }

  createconversationroom(String chatroomid, chatroomMap)
  {
    Firestore.instance.collection("conversation").document(chatroomid).setData(chatroomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationmessage(String chatroomid, messageMap)
  {
    Firestore.instance.collection("chatroom").document(chatroomid).collection("chats").add(messageMap).catchError((e)
    {
      print(e.toString());
    });
  }

  getConversationmessage(String chatroomid) async
  {
    return await Firestore.instance.collection("chatroom").document(chatroomid).collection("chats").orderBy("time"
    , descending: false).snapshots();
  }

  getchatrooms(String username) async
  {
    return await Firestore.instance.collection("Chatroom").where("users", arrayContains: username).snapshots();
  }
}