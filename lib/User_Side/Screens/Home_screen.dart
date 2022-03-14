import 'package:discoveryourplate/User_Side/Screens/cart_screen.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/horizontal_products.dart';
import 'package:discoveryourplate/User_Side/modal/popular_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Home_Screen extends StatefulWidget {
  static const routename = "home_screen";
  static const IconData shopping_cart =
      IconData(0xe9de, fontFamily: 'MaterialIcons');

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool ispreesed = true;
 @override
  void initState() {
    // TODO: implement initState
   current_index=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,

              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,

                    decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "",
                              style: TextStyle(color: Colors.white,                      fontFamily: 'SFUIText-Regular',
                                fontWeight: FontWeight.bold,
                              fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),

                          Container(

                            padding: EdgeInsets.only(left: 15),
                            child: Row(
                              children: [


                                Icon(Icons.location_on_outlined,color: Color(0xffDADADA),),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02),

                                Text("Monal  Rawalpindi",style: TextStyle(color: Color(0xffFFFFFF),fontSize: 16,fontFamily: 'SFUIText-Regular'),),

                            IconButton(icon: Icon(Icons.search),color: Colors.white,iconSize: 17,onPressed: (){

                            },),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.17),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.04,
                                  width:
                                  MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.shopping_basket_outlined,
                                        size: 40,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
Navigator.of(context).pushNamed(Cart_Screen.routename);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height * 0.02),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          //serach

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 80,right: 30),
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
                      width: 350,
                      height: MediaQuery.of(context).size.height*0.45,
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 30,
                        child: SvgPicture.asset('images/clubgrublogo.svg'),

                            ),
                    ),
                    ),

                ],
              ),
            ),
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  color: Color(0xff131010),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),


            food_side_Horizontal_products(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Popular Food",
                style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  fontSize: 24,
                  color: Color(0xff131010),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            Recomended_Product_Screen()

          ],
        ),
      ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}

//
