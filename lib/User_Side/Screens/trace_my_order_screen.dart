import 'dart:convert';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';

class Trace_Status_Screen extends StatefulWidget {
  static const routename = "Trace_My_Order_Screen";

  @override
  _Trace_Status_ScreenState createState() => _Trace_Status_ScreenState();
}

class _Trace_Status_ScreenState extends State<Trace_Status_Screen> {



@override
  void dispose() {
    // TODO: implement dispose

  super.dispose();
  }
  @override

  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Track your Order",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [

              Card(
                margin: EdgeInsets.only(left: 15, right: 10,top: 10),
                color: Color(0xffF5F5F5),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("https://i.pinimg.com/originals/2e/39/ae/2e39ae43a252f6d5dde9d9337526530d.jpg"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("(Driver)",style: TextStyle(color: Color(0xff0B2E40),)),
                        SizedBox(
                          width: 160,
                        ),
                        CircleAvatar(
                          child: Icon(Icons.call, color: Color(0xffFFFFFF),size: 11.23,),
                          backgroundColor: mycolor,
                          radius: 13,
                        ),
                      ],
                    )),
              ),
              Container(
                height: (MediaQuery.of(context).size.height * 0.6),
                width: double.infinity,
                margin: EdgeInsets.only(left: 15, right: 10, top: 50),
                child: Column(
                  children: [
                    //order placed
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: mycolor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: mycolor),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(
                          width: 25,
                        ),
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Placed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text("Your Order has been recieved")
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  //confirmed
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: mycolor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: mycolor),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Confirmed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Your Order has been recieved")
                  ],
                ))
          ],
        ),
                    SizedBox(
                      height: 40,
                    ),


                    Row(
                      children: [
                   Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: mycolor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: mycolor),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(
                          width: 25,
                        ),
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order En Route",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text("Your Order has been recieved")
                              ],
                            ))
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
        Row(
          children: [

         Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: mycolor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),

            ),
            SizedBox(
              width: 25,
            ),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivered",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Your Order has been recieved")
                  ],
                ))
          ],
        ),

                    SizedBox(
                      height: 40,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: User_Bottom_Navigation_Bar(),
      ),
    );
  }
}
