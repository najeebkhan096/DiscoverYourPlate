// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:foodies/User_Side/widgets/bottom_navigation_bar.dart';
//
//
// class Favourite extends StatelessWidget {
//   static const routename = "favourite_screen";
//   @override
//   List favourite_item_name = ['Daruma', 'Spagetti Box'];
//
//   List url = [
//     'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',
//     'https://ph-web-bucket.s3.us-east-2.amazonaws.com/data/img/home_sliders/1614850193-800x550.png'
//   ];
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.only(left: 20, top: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //latest
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Text(
//                   "Latest",
//                   style: TextStyle(
//                       color: Color(0xff000000),
//                       fontFamily: 'ProximaNova-Regular',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 22),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//
//               //listview
//               Container(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   child: ListView.builder(
//                     itemBuilder: (ctx, index) {
//                       return Column(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.13,
//                                 width: MediaQuery.of(context).size.width * 0.94,
//                                 child: Row(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 07,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.26,
//                                         child: food_side_popular_food_list[index].imageurl.isEmpty?Text(""):FittedBox(
//                                             fit: BoxFit.fill,
//                                             child: Image.network(food_side_popular_food_list[index].imageurl)),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.025,
//                                     ),
//                                     Container(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               1,
//                                       width: MediaQuery.of(context).size.width *
//                                           0.4,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                               child: Text(
//                                                 food_side_popular_food_list[index].title,
//                                             style: TextStyle(
//                                                 color: Color(0xff000000),
//                                                 fontFamily:
//                                                     'ProximaNova-Regular',
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 16),
//                                           )),
//                                           SizedBox(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.006,
//                                           ),
//                                           Container(
//                                               child: Text(
//                                                 food_side_popular_food_list[index].subtitle,
//                                             style: TextStyle(
//                                                 color: Color(0xff7E7B7B),
//                                                 fontFamily:
//                                                     'ProximaNova-Regular',
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 14),
//                                           )),
//                                           SizedBox(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.015,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.028,
//                                     ),
//                                     Container(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               1,
//                                       width: MediaQuery.of(context).size.width *
//                                           0.22,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "\$${food_side_popular_food_list[index].price}",
//                                             style: TextStyle(
//                                                 color: mycolor,
//                                                 fontFamily:
//                                                     'ProximaNova-Regular',
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 16),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.013,
//                           ),
//                         ],
//                       );
//                     },
//                     itemCount: food_side_popular_food_list.length,
//                     shrinkWrap: true,
//                   )),
//
//               SizedBox(
//                 height: 10,
//               ),
//
//               //your recent order
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Text("Your recent Order...",
//                         style: TextStyle(
//                             color: Color(0xff0B2E40),
//                             fontFamily: 'ProximaNova-Regular',
//                             fontWeight: FontWeight.w700,
//                             fontSize: 22)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 25),
//                     child: Container(
//                         child: Text("Show all",
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Color(0xff66Ad27),
//                             ))),
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context,index){
//                   return Container(
//
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Container(
//                             height: 130,
//                             width: 120,
//
//                             child: Text("")
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         Text(
//                           food_side_delievery_orders[index].products[0].title,
//                           style: TextStyle(
//                               color: Color(0xff000000),
//                               fontFamily: 'ProximaNova-Regular',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.008,
//                         ),
//                         Text(
//                           "\$${food_side_delievery_orders[index].products[0].price.toString()}",
//                           style: TextStyle(
//                               color: Color(0xff7E7B7B),
//                               fontFamily: 'ProximaNova-Regular',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                   itemCount: food_side_delievery_orders.length,
//                 ),
//               )
//             ],
//           ),
//         ),
//         bottomNavigationBar: food_side_Bottom_navigation_bar(),
//       ),
//     );
//   }
// }
//
