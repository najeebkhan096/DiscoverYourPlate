import 'package:discoveryourplate/Restuarent_Side/screens/menu_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/activestock.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/nonactivestock.dart';

import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';

class Stock_Screen extends StatefulWidget {
  static const routename = "Stock_Screen";
  @override
  _Stock_ScreenState createState() => _Stock_ScreenState();
}

class _Stock_ScreenState extends State<Stock_Screen>
    with SingleTickerProviderStateMixin {
  @override
  Color active = mycolor;
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _controller.dispose();
  }

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Stock",
            style: TextStyle(color: Colors.black),
          ),
        actions: [
 Container(
   margin: EdgeInsets.only(right: width*0.03),
   child: CircleAvatar(
     backgroundColor: Colors.black,
     child: IconButton(
       onPressed: (){
Navigator.of(context).pushNamed(Menu_Screen.routename);
       },
       icon: Icon(Icons.add),
     ),
   ),
 ),
        ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: height * 1,
            child: Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.85,
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Color(0xffCCCCCC),
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 10,
                        color: Color(0xff9099A6),
                        fontWeight: FontWeight.w600),
                    isScrollable: true,

                    indicatorWeight: height * 0.004,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.w600),
                    controller: _controller,

              indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)),
                    tabs: [
                      Container(
width: width*0.3,
                        child: Tab(
                          child: // Adobe XD layer: 'Emergency (6)' (text)
                              Text(
                            'Active',
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.3,
                        child: Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                              Text(
                            'Non Active',
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.025,),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      Active_Stock(),
                     NonActive_Stock()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

