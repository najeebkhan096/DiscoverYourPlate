import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Restuarent_Ongoing_Orders extends StatelessWidget {
  Database _database = Database();
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
              .where((element) => (element['order_status'] == "ongoing"))
              .toList();
          final int messageCount = precist.length;

          return precist.length == 0
              ? Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.45,
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Text(
                    "No Order",
                    style: TextStyle(fontSize: 18),
                  ))
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: messageCount,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot document = precist[index];
                    return Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(
                                  "RECIEVED",
                                  style: TextStyle(
                                      fontFamily: 'SFUIText-Regular',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.green),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                ),
                                Text(
                                  document['date'].toString(),
                                  style: TextStyle(
                                      fontFamily: 'SFUIText-Regular',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff2E3034)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //products
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        (0.05 *
                                            (document['products'] as List)
                                                .length),
                                    child: ListView.builder(
                                      itemBuilder: (ctx, productindex) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 17, right: 10, top: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                child: Text(
                                                  (document['products']
                                                                      as List)[
                                                                  productindex]
                                                              ['quantity']
                                                          .toString() +
                                                      "x",
                                                  style: TextStyle(
                                                    color: Color(0xff2E3034),
                                                    fontFamily:
                                                        'SFUIText-Regular',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
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
                                                  (document['products']
                                                              as List)[
                                                          productindex]['title']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff2E3034),
                                                    fontFamily:
                                                        'SFUIText-Regular',
                                                    fontWeight: FontWeight.w500,
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
                                                  "${(document['products'] as List)[productindex]['price']}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SFUIText-Regular',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff747D8C)),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          (document['products'] as List).length,
                                    )),
                                Divider(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),

                                //customer name
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer name: " +
                                            document['customer_name']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'SFUIText-Regular',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2E3034)),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),

                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 35),
                                              child: Text(
                                                "OrderID: " +
                                                    document.id.toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SFUIText-Regular',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff747D8C)),
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),

                                      //location
                                      Text(
                                        "location: " +
                                            document['location'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'SFUIText-Regular',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff747D8C)),
                                      ),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Divider(),

                                      //notes
                                      Text(
                                        "Order Notes",
                                        style: TextStyle(
                                          fontFamily:
                                              'Proxima Nova Condensed Bold',
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        document['notes'].toString(),
                                        style: TextStyle(
                                          fontFamily:
                                              'Proxima Nova Condensed Bold',
                                          color: Color(0xff747D8C),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "To Pay ${document['total_price']}",
                                              style: TextStyle(
                                                fontFamily:
                                                    'Proxima Nova Condensed Bold',
                                                color: Color(0xff747D8C),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.058,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: RaisedButton(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              color: Colors.red,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                _database.updateOrderStatus(
                                                    doc: document.id.toString(),
                                                    status: 'cancelled');
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: RaisedButton(
                                              child: Text(
                                                'Accept',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              color: Colors.green,
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                _database.AssignDeliveryBoy().then((data) {

                                                  _database.updateOngoingOrder(
                                                      doc: document.id.toString(),
                                                      status: 'in_progress',
                                                    worker_cnic: data!['cnic'],
                                                    worker_name: data['worker_name']
                                                  );
                                                });

                                              },
                                            ),
                                          ),
                                        ],
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
                  },
                );
        });
  }
}
