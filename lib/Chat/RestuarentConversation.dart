import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Chat/chatscreen.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/restuarent_data.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class RestuarentConversation extends StatelessWidget {
  static const id = "RestuarentConversation";

  Database _database=Database();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Chat with Users",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(

        child: ListView(
          children: [


            FutureBuilder(
                future: _database.fetchusers(),
                builder: (BuildContext context,AsyncSnapshot<List<User_Data>?> snapshot){

                  return snapshot.connectionState==ConnectionState.waiting?

                  SpinKitRotatingCircle(color: Colors.black,):

                  (snapshot.hasData && snapshot.data!.length>0 )?

                  Column(

                    children: List.generate(snapshot.data!.length, (index) => Container(
                      margin: EdgeInsets.only(left:width*0.05,right: width*0.05 ),
                      child: ListTile(

                        leading:
                        (snapshot.data![index].imageurl==null || snapshot.data![index].imageurl!.isEmpty)?
                        CircleAvatar(
                          radius: 25,
                          child: Text("No Image"),
                        ):
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(snapshot.data![index].imageurl!),
                        ),

                        title: Text(snapshot.data![index].name!,style: TextStyle(
                            color: Colors.black
                        )),
                        trailing: InkWell(
                            onTap: ()async{

                              MyUser chatter=MyUser(
                                  snapshot.data![index].uid.toString(),
                                  snapshot.data![index].imageurl
                                  ,
                                  snapshot.data![index].name
                              );
                              Database socialdatabase=Database();
                              socialdatabase
                                  .getUserInfogetChats(snapshot
                                  .data![index].uid
                                  .toString())
                                  .then((value) {
                                print(
                                    "so final chatroom id is " +
                                        value.toString());
                                Navigator.of(context).pushNamed(
                                  Chat_Screen.routename,
                                  arguments: [
                                    value.toString(),
                                    chatter
                                  ],
                                );

                                //
                              });
                            },
                            child: Chip(label: Text("Chat",style: TextStyle(color: Colors.white)),backgroundColor:   Colors.teal.shade300,)),

                      ),
                    )),
                  )

                      :Text("No Data");
                }),
          ],
        ),
      ),
      bottomNavigationBar: Restuarent_Bottom_Navigation_Bar(),
    );
  }
}
