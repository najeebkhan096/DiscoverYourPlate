import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/GoogleMap/tracking.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/mapkey.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:discoveryourplate/hybrid_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

class Worker_Order_Status_Screen extends StatefulWidget {
  static const routename = "Worker_Order_Status_Screen";

  @override
  _Worker_Order_Status_ScreenState createState() =>
      _Worker_Order_Status_ScreenState();
}

class _Worker_Order_Status_ScreenState extends State<Worker_Order_Status_Screen>
    with SingleTickerProviderStateMixin {
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

  String worker_doc_id = '';
  String a = '';
  Future update_active_status({String? doc_id, bool? status}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Workers');

    setState(() {
      collection.doc(doc_id).update({'active_status': status});
    });
  }

  Position? _position;
  Future update_order_status({String? doc_id}) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Orders');
      collection.doc(doc_id).update({
        'order_status':'delivery',
        'worker_latitude': _position!.latitude,
        'worker_longitude': _position!.longitude
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future update_order_completed({String? doc_id}) async {
    try {
      CollectionReference collection =
      FirebaseFirestore.instance.collection('Orders');
      collection.doc(doc_id).update({
        'order_status':'completed',
      });
    } catch (e) {
      print(e.toString());
    }
  }
  String? current_location;

  void _showErrorDialog(String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Map<String, dynamic>? workerdata;
  @override
  Widget build(BuildContext context) {
    workerdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(workerdata!['name'].toString());
    worker_name = workerdata!['name'].toString();

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Welcome " + worker_name.toString(),
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 10),
                  child: InkWell(
                      onTap: () {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        _auth.signOut().then(
                          (value) {
                            Navigator.of(context)
                                .pushReplacementNamed(Wrapper.routename);
                          },
                        );
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                )
              ],
            ),
            body: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Orders').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return SpinKitCircle(
                      color: Colors.black,
                    );
                  if (!snapshot.hasData) return const Text('Loading...');
                  List<QueryDocumentSnapshot> precist = snapshot.data!.docs
                      .where((element) =>
                          (element['order_status'] == "in_progress" || element['order_status'] == "delivery")  )
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
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 20),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //products
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                (0.05 *
                                                    (document['products']
                                                            as List)
                                                        .length),
                                            child: ListView.builder(
                                                itemBuilder:
                                                    (ctx, productindex) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 17,
                                                        right: 10,
                                                        top: 20),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                          child: Text(
                                                            document['products']
                                                                        [index]
                                                                    ['title']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2E3034),
                                                              fontFamily:
                                                                  'SFUIText-Regular',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount: (document['products']
                                                        as List)
                                                    .length)),
                                        Divider(),
                                        SizedBox(
                                          height: MediaQuery.of(context)
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Customer name: " +
                                                    document['customer_name']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SFUIText-Regular',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff2E3034)),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Date and Time :",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SFUIText-Regular',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff2E3034)),
                                                  ),
                                                  Text(
                                                    document['date'].toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SFUIText-Regular',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff2E3034)),
                                                  )
                                                ],
                                              ),

                                              SizedBox(
                                                height: MediaQuery.of(context)
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 35),
                                                      child: Text(
                                                        "OrderID: " +
                                                            document.id
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SFUIText-Regular',
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff747D8C)),
                                                      ),
                                                    ),
                                                  ]),

                                              //delivery boy

                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),

                                              //location
                                              Text(
                                                "location: " +
                                                    document['location'],
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SFUIText-Regular',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff747D8C)),
                                              ),

                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                              Divider(),

                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.058,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        'Start',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      color: Colors.green,
                                                      textColor: Colors.white,
                                                      onPressed: () async {
                                                        Database database =
                                                            Database();
                                                        GoogleLocation
                                                            _location =
                                                            GoogleLocation();
                                                        _position = await _location
                                                            .determinePosition();
                                                        current_location =
                                                            await _location
                                                                .GetAddressFromLatLong(
                                                                    _position!);
                                                        print(
                                                            "Your Location is" +
                                                                current_location
                                                                    .toString());
                                                        print(document.id.toString());
                                                   await update_order_status(doc_id: document.id.toString()).then((value) {
                                                     Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (BuildContext context) => Tracking_Screen(
                                                                 user_id:document.id,
                                                                 ini: LatLng(
                                                                     _position!
                                                                         .latitude,
                                                                     _position!
                                                                         .longitude),
                                                                 final_pos: LatLng(
                                                                     document[
                                                                     'customer_latitude'],
                                                                     document[
                                                                     'customer_longitude']))));
                                                   });

                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.058,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        'Delivered',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      color: Colors.green,
                                                      textColor: Colors.white,
                                                      onPressed: () async {
    await update_order_completed(doc_id: document.id.toString());

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
                })));
  }
}
