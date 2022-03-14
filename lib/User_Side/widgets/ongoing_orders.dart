import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Ongoing_Orders extends StatelessWidget {
  Database database = Database();

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
              .where((element) => (element['userid'] == user_id &&
                  element['order_status'] == "ongoing"))
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
            ListView.builder(
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
                          child: Text("Status : Ongoing")),
                    ],
                  ),
                ),
              );
            },
          );

        });
  }
}
