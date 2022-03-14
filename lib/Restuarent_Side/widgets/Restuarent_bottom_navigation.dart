
import 'package:discoveryourplate/Restuarent_Side/screens/Admin_Orders_Screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Restuarent_Dashboard.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/notification_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/restuarent_profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';



int restuarent_current_index=0;
class Restuarent_Bottom_Navigation_Bar extends StatefulWidget {
  const Restuarent_Bottom_Navigation_Bar({Key? key}) : super(key: key);

  @override
  State<Restuarent_Bottom_Navigation_Bar> createState() => _Restuarent_Bottom_Navigation_BarState();
}

class _Restuarent_Bottom_Navigation_BarState extends State<Restuarent_Bottom_Navigation_Bar> {
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
        selectedIndex: restuarent_current_index,
        onDestinationSelected: (index){
          setState(() {
            restuarent_current_index=index;
          });
          if(restuarent_current_index==0){
            Navigator.of(context).pushReplacementNamed(Restuarent_Dashboard.routename)
        .then((value) {

              setState(() {

              });
            });
          }
          if(restuarent_current_index==1){
            print("hello");
             Navigator.of(context).pushReplacementNamed(Admin_Order_Screen.routename);

          }
          if(restuarent_current_index==2){
             Navigator.of(context).pushReplacementNamed(Notification_Screen.route).then((value) {
              setState(() {

              });
            });
//
          }
          if(restuarent_current_index==3){

            Navigator.of(context).pushReplacementNamed(Restuarent_Profile_screen.routname).then((value) {
              setState(() {

              });
            });
          }


          print(restuarent_current_index);
        },
        backgroundColor: Colors.white,
        destinations: [

          NavigationDestination( icon:  Icon(
                      Icons.home,
                       color: Colors.green,
                     ),label: "Home",),


          NavigationDestination( icon:
          Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.green,
                  ),
              label: "MyOrders"),

          NavigationDestination( icon: Icon(
                  Icons.notification_important,
                  color: Colors.green,),label: "Notification",),
          NavigationDestination( icon:  Icon(

                      Icons.account_circle,

                    color: Colors.green,
                  ),label: "Profile"),



        ],
      ),
    );
  }
}
