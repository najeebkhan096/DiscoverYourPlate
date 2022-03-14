import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class View_worker extends StatefulWidget {
  static const routename = 'View_worker';
  @override
  _View_workerState createState() => _View_workerState();
}

class _View_workerState extends State<View_worker> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("View Worker",style: TextStyle(color: Colors.black,fontSize: 15),),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
body:  StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Workers').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return SpinKitCircle(
          color: Colors.black,
        );
      if (!snapshot.hasData) return const Text('Loading...');
      List<QueryDocumentSnapshot> precist = snapshot.data!.docs
          .where((element) => (element['restuarent_id'] == restuarent_id.toString()))
          .toList();
      final int messageCount = precist.length;

      return precist.length == 0
          ? Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.45,
              top: MediaQuery.of(context).size.height * 0.2),
          child: Text(
            "No Worker",
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
            margin: EdgeInsets.all(11),
            elevation: 2,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                     document['imageurl'].toString().isEmpty?SpinKitCircle(color: Colors.white,):  CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        NetworkImage(document['imageurl'].toString()),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height * 0.055,
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0,top: 12),
                            child: Text(document['Name'].toString(),style: TextStyle(color: Colors.black),),
                          )),

                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height * 0.055,
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0,top: 12),
                            child: Text(document['cnic'].toString(),style: TextStyle(color: Colors.black),),
                          )),


                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    })
          
      ),
    );
  }
}
