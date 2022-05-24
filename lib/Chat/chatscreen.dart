
import 'package:discoveryourplate/Chat/ChatMessage.dart';
import 'package:discoveryourplate/Chat/chat_bubble.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/Chart/constants.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType{
  Sender,
  Receiver,
}
class Chat_Screen extends StatefulWidget {


  static const routename = "Chat_Screen";
  static const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  TextEditingController message = TextEditingController();

  Constants _const=Constants();
  List<ChatMessage> messages_list=[
    ChatMessage(message: "Hi",type: MessageType.Sender,),
    ChatMessage(message: "Hello",type: MessageType.Receiver),
    ChatMessage(message: "How are you?",type: MessageType.Sender),
    ChatMessage(message: "Fine",type: MessageType.Receiver)
  ];
  String chatid = '';

  MyUser? user;



  @override
  void dispose() {
    // TODO: implement dispose
    message.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("step1");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List data= ModalRoute.of(context)!.settings.arguments as List;
    try{
      chatid=data[0];
      user=data[1];

    }catch(error){

    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: //body
      ListView(
        children: [
          Container(
            height: height*0.86,
            child: ListView(

              children: [

                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: mycolor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0)),
                  ),
                  child:  Center(
                    child: Container(
margin: EdgeInsets.only(left: width*0.1),
                      child: Row(

                        children: [
                          InkWell(
                              onTap: () {
                            Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child:Icon(Icons.arrow_back_ios)
                              )),
                          Container(
                            margin:  EdgeInsets.only(left: width*0.15),
                            child: Text(
                              user!.username.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SFUIText-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //chat screen

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.
                        collection("chatRoom")
                            .doc(chatid)
                            .collection("chats")
                            .orderBy('time')
                            .snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){


                          return snapshot.hasData?

                          Column(

                            children: List.generate(snapshot.data!.docs.length, (index) =>
                                ChatBubble(
                                  chatMessage: ChatMessage(
                                      message: snapshot.data!.docs[index]['message'],
                                      type:
                                      snapshot.data!.docs[index]['SendBy']==user_id?
                                      MessageType.Sender
                                          :
                                      MessageType.Receiver

                                  ),
                                )
                            ),
                          )

                              :Text("no data");
                        }),


                  ],
                ),

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(
                left: width * 0.05, right: width * 0.05),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: mycolor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width * 0.55,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                      controller: message,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write a message here",
                          hintStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.only(left: 20))),
                ),
                InkWell(
                    onTap: () {
                      Database _database=Database();
                      _database.addMessage(
                          chatRoomId: chatid,
                          chatMessageData: {
                            'message': message.text,
                            'SendBy': user_id,
                            'time':DateTime.now().millisecondsSinceEpoch
                          }).then((value) {
                        message.clear();
                      });
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child:Icon(Icons.send)
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
