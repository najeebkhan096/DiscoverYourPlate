import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/GoogleMap/tracking.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InProgress extends StatefulWidget {
  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  Database database = Database();
  Position ? _position;
  String ? current_location;
  bool isloading = false;
  void _showErrorDialog(String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Alert'),
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

  double final_total = 0;
  String? _order_doc_id;
  String? category_id;

  Future<void> printsome() async {
    print("hello");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: printsome,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          List<QueryDocumentSnapshot> precist = snapshot.data!.docs
              .where((element) => (element['userid'] == user_id && (element['order_status']=="in_progress" || element['order_status']=="delivery"))
          )
              .toList();
          final int messageCount = precist.length;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              final DocumentSnapshot document = precist[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 5),
                        child: Text("OrderID:" + document.id.toString(),
                            style: TextStyle(
                                fontFamily: '0xff0F0E49',
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(document['date'].toString())),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text("Status : In Progress")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      document['order_status']=="delivery"?

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: RaisedButton(
                                child: Text(
                                  'Track',
                                  style: TextStyle(fontSize: 16),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                                  'worker_latitude'],
                                                  document[
                                                  'worker_longitude']))));
                                },
                              ),
                            ),
                            // RaisedButton(onPressed: (){},child: Text("Track",style: ,),color: Colors.blue,),
                          ],
                        ),
                      )
                          :
                      Text("")

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}
