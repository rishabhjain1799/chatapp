import 'package:chatapp/constants.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/widget.dart';
import 'package:flutter/material.dart';

class conversation extends StatefulWidget {

  final String chatroomid;
  conversation(this.chatroomid);

  @override
  _conversationState createState() => _conversationState();
}

DatabaseMethods databaseMethods = new DatabaseMethods();
TextEditingController messagecontroller = new TextEditingController();

Stream chatmessageStream;

class _conversationState extends State<conversation> {

  Widget chatMessagelist()
  {
    return StreamBuilder(
      stream: chatmessageStream,
      builder: (context, snapshot)
      {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index)
          {
            return MessageTile(snapshot.data.documents[index].data["message"],
            snapshot.data.documents[index].data["sendBy"] == constants.myName
            );
          }
          ) : Container();
      },
    );
  }

  sendMessage()
  {
    if(messagecontroller.text.isNotEmpty)
    {
      Map<String,dynamic> messageMap = {
      "sendBy" : constants.myName,
      "message" : messagecontroller.text,
      "time" : DateTime.now().millisecondsSinceEpoch,
    };

    databaseMethods.addConversationmessage(widget.chatroomid, messageMap);
    setState(() {
      messagecontroller.text = "";
    });
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationmessage(widget.chatroomid).then((value)
    {
      setState(() {
        chatmessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
    decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"), 
              fit: BoxFit.cover,
            )
          ),
          child: Stack(
            children: <Widget>[
              chatMessagelist(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messagecontroller,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22
                        ),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          hintStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ),
                    GestureDetector(
                      onTap: ()
                      {
                        sendMessage();
                      },
                        child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Image.asset("assets/images/send.png")
                      ),
                    ),
                  ],
                ),
            ),
              ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {

  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 4 ,right: isSendByMe ? 4 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSendByMe ? Colors.red : Colors.blue,
              borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
              ) : 
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)
              ),
            ),
        child: Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 20,
           fontFamily: 'OverpassRegular',
        ),
        ),
      ),
    );
  }
}