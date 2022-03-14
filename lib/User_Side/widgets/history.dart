// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:food_app/food_app_constants.dart';
// import 'package:food_app/firebase_data/order.dart';
// import 'package:food_app/firebase_data/product.dart';
// import 'package:foodies/User_Side/modal/food_app_constants.dart';
// import 'package:http/http.dart' as http;
// class food_side_History extends StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//     print(food_side_delievery_orders.length);
//     return FutureBuilder(
//       future: food_side_get_delivery_orders(),
//       builder: (context,snapshot){
//         return snapshot.hasData?Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             margin: EdgeInsets.only(left: 10, right: 10),
//             height: MediaQuery.of(context).size.height * 0.78,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               physics: BouncingScrollPhysics(),
//               itemBuilder: (ctx, index) {
//                 return Column(
//                   children: [
//                     Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(9)),
//                         elevation: 1.5,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 16, top: 5),
//                               child: Text(food_side_delievery_orders[index].order_no.toString(),
//                                   style: TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.bold)),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 16),
//                               child: Text(
//                                   food_side_delievery_orders[index].dateTime.toIso8601String()),
//                             ),
//                             ListTile(
//                               leading: Text(
//                                 "${food_side_delievery_orders[index].totalamount}-${food_side_delievery_orders[index].quantity} item-Cash",
//                                 style: TextStyle(
//                                   color: mycolor,
//                                 ),
//                               ),
//                               title: IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(Icons.expand_more, color: mycolor)),
//                               trailing: Container(
//                                   decoration: BoxDecoration(
//                                       border:
//                                       Border.all(color: mycolor, width: 1.1),
//                                       borderRadius: BorderRadius.circular(11)),
//                                   height: 25,
//                                   width: 90,
//                                   child: FlatButton(
//                                     onPressed: () {
//
//                                     },
//                                     child: Text(
//                                       "Re order",
//                                       style: TextStyle(color: mycolor),
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         )),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.013,
//                     ),
//                   ],
//                 );
//               },
//               itemCount: food_side_delievery_orders.length,
//             ),
//           ),
//         ):Center(child: Text("No Order History"));
//       },
//
//     );
//   }
// }
