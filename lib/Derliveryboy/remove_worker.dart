import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Derliveryboy/view_worker.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class Remove_worker extends StatefulWidget {
  static const routename = 'Remove_worker';
  @override
  _Remove_workerState createState() => _Remove_workerState();
}

class _Remove_workerState extends State<Remove_worker> {
  Future deleteData(String doc_id)async{
    CollectionReference collection=FirebaseFirestore.instance.collection('Workers');
    collection.doc(doc_id).delete();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Remove Worker",style: TextStyle(color: Colors.black,fontSize: 15),),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),

          body: StreamBuilder(
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
                    Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete,color: Colors.red,),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                                        InkWell(
                                            onTap: (){

deleteData(document.id.toString());
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Removed Worker",
                                                  toastLength:
                                                  Toast
                                                      .LENGTH_SHORT,
                                                  gravity:
                                                  ToastGravity.BOTTOM_LEFT,
                                                  timeInSecForIosWeb:
                                                  1,
                                                  backgroundColor:
                                                  Colors
                                                      .green,
                                                  textColor:
                                                  Colors
                                                      .white,
                                                  fontSize:
                                                  16.0);
                                            },
                                            child : Text("Remove Worker",style: TextStyle(color: Colors.red),)),
                              ],
                            ),
                          ),
                        ],
                      ),)
                    ]
                    ),
                    );
                  },
                );
              })

          // FutureBuilder(
          //   future: Provider.of<Worker_Profile_Data>(context,listen: false).Fetch_Worker_Profile_Data(),
          //   builder: (context,AsyncSnapshot<List<Worker_Profile_Data>>snapshot){
          //     return snapshot.hasData?
          //     Container(
          //       height: MediaQuery.of(context).size.height*1,
          //       child: ListView.builder(itemBuilder: (BuildContext context,index){
          //         return  Card(
          //           margin: EdgeInsets.all(11),
          //           elevation: 2,
          //           child: Column(
          //             children: [
          //               SizedBox(height: MediaQuery.of(context).size.height*0.04,),
          //               SingleChildScrollView(
          //                 child: Column(
          //                   children: [
          //                     SizedBox(
          //                       height: MediaQuery.of(context).size.height * 0.03,
          //                     ),
          //                     snapshot.data![index].imageurl.toString().isEmpty?SpinKitCircle(color: Colors.white,):  CircleAvatar(
          //                       radius: 50,
          //                       backgroundImage:
          //                       NetworkImage(snapshot.data![0].imageurl.toString()),
          //                     ),
          //                     SizedBox(
          //                       height: MediaQuery.of(context).size.height * 0.005,
          //                     ),
          //                     Container(
          //                         width: MediaQuery.of(context).size.width*0.8,
          //                         height: MediaQuery.of(context).size.height * 0.055,
          //                         margin: EdgeInsets.all(15),
          //                         padding: EdgeInsets.symmetric(horizontal: 15),
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(15),
          //                             color: Colors.black12
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.only(left: 6.0,top: 12),
          //                           child: Text(snapshot.data![index].name.toString(),style: TextStyle(color: Colors.black),),
          //                         )),
          //
          //                     Container(
          //                         width: MediaQuery.of(context).size.width*0.8,
          //                         height: MediaQuery.of(context).size.height * 0.055,
          //                         margin: EdgeInsets.all(15),
          //                         padding: EdgeInsets.symmetric(horizontal: 15),
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(15),
          //                             color: Colors.black12
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.only(left: 6.0,top: 12),
          //                           child: Text(snapshot.data![index].profession.toString(),style: TextStyle(color: Colors.black),),
          //                         )),
          //                     Container(
          //                         width: MediaQuery.of(context).size.width*0.8,
          //                         height: MediaQuery.of(context).size.height * 0.055,
          //                         margin: EdgeInsets.all(15),
          //                         padding: EdgeInsets.symmetric(horizontal: 15),
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(15),
          //                             color: Colors.black12
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.only(left: 6.0,top: 12),
          //                           child: Text(snapshot.data![index].Experiance.toString(),style: TextStyle(color: Colors.black),),
          //                         )),
          //
          //
          //                     SizedBox(
          //                       height: MediaQuery.of(context).size.height * 0.01,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(bottom: 20),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(Icons.delete,color: Colors.red,),
          //                     SizedBox(width: MediaQuery.of(context).size.width*0.04,),
          //                     InkWell(
          //                         onTap: (){
          //                           Provider.of<Worker_Profile_Data>(context,listen: false).deleteData(snapshot.data![index].document_id.toString());
          //                           setState(() {
          //
          //                           });
          //                           Fluttertoast.showToast(
          //                               msg:
          //                               "Removed Worker",
          //                               toastLength:
          //                               Toast
          //                                   .LENGTH_SHORT,
          //                               gravity:
          //                               ToastGravity.BOTTOM_LEFT,
          //                               timeInSecForIosWeb:
          //                               1,
          //                               backgroundColor:
          //                               Colors
          //                                   .green,
          //                               textColor:
          //                               Colors
          //                                   .white,
          //                               fontSize:
          //                               16.0);
          //                         },
          //                         child : Text("Remove Worker",style: TextStyle(color: Colors.red),)),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //         itemCount: snapshot.data!.length,
          //       ),
          //     ):SpinKitCircle(
          //       color: Colors.black,
          //     );
          //   },
          // )
      ),
    );
  }
}
