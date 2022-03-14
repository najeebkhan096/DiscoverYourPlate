import 'package:discoveryourplate/Restuarent_Side/screens/menu_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/active_stock.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
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
                            'InProgress',
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
                      Active_Stock(),
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
// body: Container(
//   child: Column(
//     children: [
//       Card(
//         elevation: 0,
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.15,
//           padding: EdgeInsets.only(top: 15),
//           child: Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 15),
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.45,
//                 child: RaisedButton(
//                   elevation: 0.1,
//                   child: Text(
//                     'Active',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: isrecieved
//                             ? Colors.white
//                             : Color(0xffA4B0BE)),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   color: isrecieved ? mycolor : Color(0xffF9F9F9),
//                   textColor: Colors.white,
//                   onPressed: () {
//                     setState(() {
//                       isrecieved = true;
//                       print(isrecieved);
//                     });
//
//                     // Navigator.of(context).pushNamed(Email_Screen.routename);
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.01,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.45,
//                 child: RaisedButton(
//                   elevation: 0.6,
//                   child: Text(
//                     'Non Active',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: isrecieved
//                             ? Color(0xffA4B0BE)
//                             : Colors.white),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   color: isrecieved ? Color(0xffF9F9F9) : mycolor,
//                   textColor: Colors.white,
//                   onPressed: () {
//                     setState(() {
//                       isrecieved = false;
//                     });
//                     // Navigator.of(context).pushNamed(Email_Screen.routename);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       SizedBox(
//         height: MediaQuery.of(context).size.height * 0.015,
//       ),
//       // Active_Stock()
//     ],
//   ),
// ),
