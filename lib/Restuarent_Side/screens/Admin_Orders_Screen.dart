import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/In_progress_orders.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/cancelled_orders.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/completed_orders.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/ongoing.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;



class Admin_Order_Screen extends StatefulWidget {
  static const routename = "Admin_Order_Screen";
  @override
  _Admin_Order_ScreenState createState() => _Admin_Order_ScreenState();
}

class _Admin_Order_ScreenState extends State<Admin_Order_Screen>
    with SingleTickerProviderStateMixin {
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  late TabController _controller;
  void _showErrorDialog(String msg,BuildContext context)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    restuarent_current_index=1;
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,

            body: ListView(
              children: [
                SizedBox(height: height*0.025,),
                Container(
                  margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                  height: height*0.08,
                  width: width*1,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffCCCCCC),width: 0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Container(

                    height: height*0.05,
                    width: width*0.85,
                    child: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Color(0xffCCCCCC),
                      indicatorColor: Colors.blue,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 10,
                          color: Color(0xff9099A6),
                          fontWeight: FontWeight.w600
                      ),
                      isScrollable: true,
                      indicatorPadding: EdgeInsets.only(top: 5),
                      indicatorWeight: height*0.004,
                      unselectedLabelStyle: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.w600
                      ),
                      controller: _controller,
                      tabs: [
                        Tab(
                          child: // Adobe XD layer: 'Emergency (6)' (text)
                          Text(
                            'Ongoing',
                            textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'InProgress',
                            textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'Completed',
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'CANCELLED',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height*0.79,
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      //pending

                      Restuarent_Ongoing_Orders(),
                      //in progress
                      Restuarent_InProgress(),

                      //completed
                      SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child : Restuarent_Completed_Orders()),


                      //cancelled
                      Restuarent_Cancelled_Orders(),
                    ],
                  ),
                ),

              ],
            ),
            bottomNavigationBar: Restuarent_Bottom_Navigation_Bar()
          ),
        ));
  }
}