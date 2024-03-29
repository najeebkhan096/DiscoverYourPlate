import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Restuarent_Completed_Orders extends StatelessWidget {

  Database database=Database();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitCircle(
              color: Colors.black,
            );
          if (!snapshot.hasData) return const Text('Loading...');
          List<QueryDocumentSnapshot> precist = snapshot.data!.docs
              .where((element) => (
              element['order_status'] == "completed"))
              .toList();
          final int messageCount = precist.length;

          return
            precist.length==0?
            Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.45,top: MediaQuery.of(context).size.height*0.2),
                child: Text("No Order",style: TextStyle(
                    fontSize: 18
                ),))
                :
                Column(
                  children: List.generate(messageCount, (index) {
                    final DocumentSnapshot document = precist[index];
                    return Card(
                      margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)
                      ),
                      elevation: 10,
                      child: Column(
                        children: [

                          SizedBox(
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.03,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                //products
                                Container(
                                    height: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        (0.05 *
                                            (document['products'] as List)
                                                .length),
                                    child: ListView.builder(
                                      itemBuilder: (ctx,
                                          productindex) {
                                        return Container(
                                          margin: EdgeInsets
                                              .only(
                                              left: 17,
                                              right: 10,
                                              top: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                child: Text(
                                                  (document['products'] as List)[productindex]
                                                  ['quantity']
                                                      .toString() +
                                                      "x",
                                                  style:
                                                  TextStyle(
                                                    color: Color(
                                                        0xff2E3034),
                                                    fontFamily:
                                                    'SFUIText-Regular',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize:
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.015,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.55,
                                                child: Text(
                                                  (document['products'] as List)[productindex]
                                                  ['title']
                                                      .toString(),
                                                  style:
                                                  TextStyle(
                                                    fontSize:
                                                    12,
                                                    color: Color(
                                                        0xff2E3034),
                                                    fontFamily:
                                                    'SFUIText-Regular',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.1,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.15,
                                                child: Text(
                                                  "${(document['products'] as List)[productindex]
                                                  ['price']}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'SFUIText-Regular',
                                                      fontSize:
                                                      12,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      color:
                                                      Color(0xff747D8C)),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:(document['products'] as List)
                                          .length,
                                    )),
                                Divider(),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02,
                                ),

                                //customer name
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "Customer name: " +
                                            document['customer_name']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily:
                                            'SFUIText-Regular',
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight
                                                .w400,
                                            color: Color(
                                                0xff2E3034)),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.02,
                                      ),




                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  right:
                                                  35),
                                              child: Text(
                                                "OrderID: " +
                                                    document.id.toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                    'SFUIText-Regular',
                                                    fontSize:
                                                    12,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    color: Color(
                                                        0xff747D8C)),
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.02,
                                      ),

                                      Text(
                                        "Worker: " +
                                            document['worker_name']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily:
                                            'SFUIText-Regular',
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            color: Color(
                                                0xff747D8C)),
                                      ),

                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.02,
                                      ),

                                      //location
                                      Text(
                                        "location: " +
                                            document['location']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily:
                                            'SFUIText-Regular',
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            color: Color(
                                                0xff747D8C)),
                                      ),

                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.02,
                                      ),
                                      Divider(),

                                      //notes
                                      Text(
                                        "Order Notes",
                                        style: TextStyle(
                                          fontFamily:
                                          'Proxima Nova Condensed Bold',
                                          color:
                                          Colors.green,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.02,
                                      ),

                                      Text(
                                        document['notes']
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily:
                                          'Proxima Nova Condensed Bold',
                                          color: Color(
                                              0xff747D8C),
                                          fontWeight:
                                          FontWeight
                                              .w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                right:
                                                20),
                                            child: Text(
                                              "To Pay ${document['total_price']}",

                                              style:
                                              TextStyle(
                                                fontFamily:
                                                'Proxima Nova Condensed Bold',
                                                color: Color(
                                                    0xff747D8C),
                                                fontWeight:
                                                FontWeight
                                                    .w400,
                                                fontSize:
                                                14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .height *
                                            0.058,
                                      ),

                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }),
                );

        });
  }
}
