import 'package:discoveryourplate/Restuarent_Side/screens/menu_screen.dart';

import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';


class Stock_Screen extends StatefulWidget {
  static const routename="Stock_Screen";
  @override
  _Stock_ScreenState createState() => _Stock_ScreenState();
}

class _Stock_ScreenState extends State<Stock_Screen> {
  @override
  Color active = mycolor;

  List url = [
    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',
    'https://www.smartertravel.com/wp-content/uploads/2020/03/purple-carrot-hero.jpg',
    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',
    'https://www.smartertravel.com/wp-content/uploads/2020/03/purple-carrot-hero.jpg',
    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',
    'https://www.smartertravel.com/wp-content/uploads/2020/03/purple-carrot-hero.jpg',
  ];
  Color inactive = Color(0xffF9F9F9);

  bool isrecieved = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Stock",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,

        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(Menu_Screen.routename);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundColor: Color(0xff2E3034),
                child: Icon(Icons.add,color: Colors.white70,),
              ),
            ),
          ),

        ],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RaisedButton(
                        elevation: 0.1,
                        child: Text(
                          'Active',
                          style: TextStyle(
                              fontSize: 16,
                              color: isrecieved
                                  ? Colors.white
                                  : Color(0xffA4B0BE)),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: isrecieved ? mycolor : Color(0xffF9F9F9),
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            isrecieved = true;
                            print(isrecieved);
                          });

                          // Navigator.of(context).pushNamed(Email_Screen.routename);
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RaisedButton(
                        elevation: 0.6,
                        child: Text(
                          'Non Active',
                          style: TextStyle(
                              fontSize: 16,
                              color: isrecieved
                                  ? Color(0xffA4B0BE)
                                  : Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: isrecieved ? Color(0xffF9F9F9) : mycolor,
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            isrecieved = false;
                          });
                          // Navigator.of(context).pushNamed(Email_Screen.routename);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            // Active_Stock()
          ],
        ),
      ),
    );
  }
}
