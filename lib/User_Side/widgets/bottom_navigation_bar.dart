
import 'package:discoveryourplate/Chat/conversation.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Admin_Orders_Screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Restuarent_Dashboard.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/notification_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/restuarent_profile.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/image_classification.dart';
import 'package:discoveryourplate/User_Side/Screens/user_order_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/user_profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';



int current_index=0;
class User_Bottom_Navigation_Bar extends StatefulWidget {
  const User_Bottom_Navigation_Bar({Key? key}) : super(key: key);

  @override
  State<User_Bottom_Navigation_Bar> createState() => _User_Bottom_Navigation_BarState();
}

class _User_Bottom_Navigation_BarState extends State<User_Bottom_Navigation_Bar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter-Regular',
                  color: Color(0xff6B6B75)

              )
          )
      ),
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: Duration(seconds: 3),
        selectedIndex: current_index,
        onDestinationSelected: (index){
          setState(() {
            current_index=index;
          });
          if(current_index==0){
            Navigator.of(context).pushReplacementNamed(Home_Screen.routename)
                .then((value) {

              setState(() {

              });
            });
          }
          if(current_index==1){
            Navigator.of(context).pushReplacementNamed(ImageClassification.routename).then((value) {
              setState(() {

              });
            });



          }
          if(current_index==2){
            Navigator.of(context).pushReplacementNamed(User_Order_Screen.routename).then((value) {
              setState(() {

              });
            });

          }

          if(current_index==3){

            Navigator.of(context).pushReplacementNamed(Conversation.id).then((value) {
              setState(() {

              });
            });

          }

          if(current_index==4){

            Navigator.of(context).pushReplacementNamed(User_Profile_Screen.routname).then((value) {
              setState(() {

              });
            });

          }
          print(current_index);
        },
        backgroundColor: Colors.white,
        destinations: [

          NavigationDestination( icon:  Icon(
            Icons.home,
            color: Colors.green,
          ),label: "Home",),


          NavigationDestination( icon:
          Image.asset('images/tourist.png',height: MediaQuery.of(context).size.height*0.025,color: Colors.green,),
              label: "Tourist"),

          NavigationDestination( icon: Icon(
            Icons.border_all,
            color: Colors.green,),label: "MyOrders",),


          NavigationDestination( icon:  Icon(
            Icons.message,
            color: Colors.green,
          ),label: "Chat"),
          NavigationDestination( icon:  Icon(
            Icons.account_circle,
            color: Colors.green,
          ),label: "Profile"),

        ],
      ),
    );
  }
}

