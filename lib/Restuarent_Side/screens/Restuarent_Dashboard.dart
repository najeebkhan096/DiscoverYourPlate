import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/Chart/barchart_module.dart';
import 'package:discoveryourplate/Restuarent_Side/Chart/sfchart.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Derliveryboy/module/worker.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;




class Restuarent_Dashboard extends StatefulWidget {
  static const routename = "Restuarent_Dashboard";

  @override
  _Restuarent_DashboardState createState() => _Restuarent_DashboardState();
}



class _Restuarent_DashboardState extends State<Restuarent_Dashboard> {
double todayearning=0;

     Future<List<BarMmodel>> fetch_completed_data() async {
todayearning=0;
    List<BarMmodel> users_data=[];
    int dec=0;
    int jan=0;
    int feb=0;
    int mar=0;
    int apr=0;
    int may=0;
    int june=0;
    int jul=0;
    int aug=0;
    int sept=0;
    int oct=0;
    int nov=0;


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {

      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;
DateTime pickeddate=DateTime.parse(fetcheddata['date'].toString());
if(DateTime.now().month==pickeddate.month && DateTime.now().year==pickeddate.year && DateTime.now().day==pickeddate.day){

  todayearning=fetcheddata['total_price'];

}
if(fetcheddata['restuarent_id'].toString()==restuarent_id){



          if(pickeddate.month==12){

            double a=double.parse(fetcheddata['total_price'].toString());
            dec=dec+a.toInt();

          }

          if(pickeddate.month==1){

            double a=double.parse(fetcheddata['total_price'].toString());
            print("u");
            jan=jan+a.toInt();

            print("done");
          }

          else if(pickeddate.month==2){
            double a=double.parse(fetcheddata['total_price'].toString());
            feb=feb+a.toInt();
          } else if(pickeddate.month==3){
            double a=double.parse(fetcheddata['total_price'].toString());
            mar=mar+a.toInt();
          } else if(pickeddate.month==4){
            double a=double.parse(fetcheddata['total_price'].toString());
            apr=apr+a.toInt();
          } else if(pickeddate.month==5){
            double a=double.parse(fetcheddata['total_price'].toString());
            may=may+a.toInt();
          } else if(pickeddate.month==6){
            double a=double.parse(fetcheddata['total_price'].toString());
            june=june+a.toInt();
          } else if(pickeddate.month==7){
            double a=double.parse(fetcheddata['total_price'].toString());
            jul=jul+a.toInt();
          } else if(pickeddate.month==8){
            double a=double.parse(fetcheddata['total_price'].toString());
            aug=aug+a.toInt();
          } else if(pickeddate.month==9){
            double a=double.parse(fetcheddata['total_price'].toString());
            sept=sept+a.toInt();
          }
          else if(pickeddate.month==10){
            double a=double.parse(fetcheddata['total_price'].toString());
            oct=oct+a.toInt();
          }
          else if(pickeddate.month==11){
            double a=double.parse(fetcheddata['total_price'].toString());
            nov=nov+a.toInt();
          }

        }


      });

    }).then((value) {

      users_data=[

        BarMmodel("Jan", jan),
        BarMmodel("Feb",feb),
        BarMmodel("Mar", mar),
        BarMmodel("Apr", apr),
        BarMmodel("May", may),
        BarMmodel("Jun", june),
        BarMmodel("Jul", jul),
        BarMmodel("Aug", aug),
        BarMmodel("Sept", sept),
        BarMmodel("Oct", oct),
        BarMmodel("Nov", nov),
        BarMmodel("Dec", dec),
      ];
    });

    return users_data;

  }

  @override
  void initState() {
    // TODO: implement initState
  restuarent_current_index=0;
    super.initState();
  }
  @override


  Future<Future<bool?>> _showErrorDialog(BuildContext context) async=> showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Alert'),
        content: Text("Do yoy want to Exit?"),
        actions: <Widget>[
          ElevatedButton(
              onPressed: ()=>Navigator.pop(context,false), child: Text("No")),
          ElevatedButton(
              onPressed: ()=>Navigator.pop(context,true), child: Text("Yes")),

        ],
      ));
  DateTime now=DateTime.now();
  int current_weekday=1;
  int previous_day=1;

  List dates=[1,2,3,4,5,6,7];

  Future<void> get_dates()async{

    int today_date=now.day;

    current_weekday=now.weekday+1;

    if(current_weekday>7){
      current_weekday=6;
      for(int i=0;i<=6;i++){

        dates[i]=today_date;

        today_date++;
      }
      current_weekday=0;
      previous_day=6;

    }
    else{

      for(int i=current_weekday-1;i>=0;i--){

        if(today_date==1){
          dates[i]=today_date;
          today_date=31;
        }
        else{

          dates[i]=today_date;

          today_date--;
        }

        }

today_date=now.day+1;
      for(int i=current_weekday;i<7;i++){

        if(today_date==30){
          today_date=0;
        }
        dates[i]=today_date;
        today_date++;

      }
      current_weekday=now.weekday;
      previous_day=current_weekday-1;
    }

    today_date=now.day;
  }

  Widget build(BuildContext context) {
    print("restuarent id "+restuarent_id.toString());
    return WillPopScope(
     onWillPop: ()async{
       bool  data=(await _showErrorDialog(context)) as bool;
       return data;
     },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView(

          children: [
            FutureBuilder(
              future: get_dates(),
              builder: (context,snapshot){

                return Card(
                  child: Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Column(
                          children: [
                            InkWell(onTap: (){
                              get_dates();
                            },child: Text("SUN")),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: current_weekday==0?mycolor:previous_day==0?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                              ),
                              height: 50,
                              width: 40,

                              child: Center(child: Text(dates[0].toString())),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Mon"),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: current_weekday==1?mycolor:previous_day==1?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                              ),
                              height: 50,
                              width: 40,
                              child: Center(child: Text(dates[1].toString())),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Tue"),
                            Container(
                              decoration: BoxDecoration(
                                color: current_weekday==2?mycolor:previous_day==2?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8)),

                              ),
                              height: 50,
                              width: 40,
                              child: Center(child: Text(dates[2].toString())),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Wed"),
                            Container(
                              decoration: BoxDecoration(
                                  color: current_weekday==3?mycolor:previous_day==3?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                              height: 50,
                              width: 40,
                              child: Center(child: Text(dates[3].toString())),
                            )
                          ],
                        ),

                        Column(
                          children: [
                            Text("Thur"),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: current_weekday==4?mycolor:previous_day==4?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,

                              ),
                              height: 50,
                              width: 40,

                              child: Center(child: Text(dates[4].toString())),
                            )
                          ],
                        ),

                        Column(
                          children: [
                            Text("FRI"),
                            Container(
                              decoration: BoxDecoration(
                                  color: current_weekday==5?mycolor:previous_day==5?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                              height: 50,
                              width: 40,
                              child: Center(child: Text(dates[5].toString())),
                            )
                          ],
                        ),

                        Column(
                          children: [
                            Text("SAT"),
                            Container(
                              decoration: BoxDecoration(
                                  color: current_weekday==6?mycolor:previous_day==6?Color.fromRGBO(102, 173, 39, 0.17):Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                              height: 50,
                              width: 40,
                              child: Center(child: Text(dates[6].toString())),

                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },

            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

      FutureBuilder(
              future: fetch_completed_data(),
              builder: (context,AsyncSnapshot<List<BarMmodel>> snapshot){

                return snapshot.connectionState==ConnectionState.waiting?
                SpinKitCircle(color: Colors.black,):
                snapshot.hasData?
                Column(
                  children: [
                    Card(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Earnings today",
                                style: TextStyle(
                                    fontFamily: 'SFUIText-Regular',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff2E3034)),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("PKR ${todayearning.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontFamily: 'SFUIText-Regular',
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff2E3034))),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.only(right: 25),
                                      child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset("images/graph2.PNG")),
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SfChart(mylist: snapshot.data!),
                  ],
                ):
                Text("No Data2");
              }),
//
            Card(
              child: Container(


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 15),
                        child: Text("Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                StreamBuilder(
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

                      return    Container(
                        margin: EdgeInsets.only(left: 10,right: 20,top: 10),
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("New Orders",
                                style: TextStyle(
                                    fontFamily: 'SFUIText-Regular',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff2E3034))),

                            Text(
                              "${precist.length.toString()}",
                              style: TextStyle(
                                fontFamily:
                                'Proxima Nova Alt Regular.otf',
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                      //new order


                      Divider(),

                      //open order
                      StreamBuilder(
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

                            return    Container(
                              margin: EdgeInsets.only(left: 10,right: 20),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("In Progress Orders",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))),

                                  Text(
                                    "${precist.length.toString()}",
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),


                      Divider(),

                      StreamBuilder(
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

                            return     Container(
                              margin: EdgeInsets.only(left: 10,right: 20),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Closed Orders",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))),

                                  Text(
                                    "${precist.length.toString()}",
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: mycolor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),



                      Divider(),

                      StreamBuilder(
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

                            return    Container(
                              margin: EdgeInsets.only(left: 10,right: 20),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Cancelled Orders",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))),

                                  Text(
                                    "${precist.length.toString()}",
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color:Color(0xffDADADA),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                    ],
                  )),
            ),
          ],
        ),
bottomNavigationBar: Restuarent_Bottom_Navigation_Bar(),
      ),
    );
  }
}

// class Restuarent_Dashboard extends StatefulWidget {
//   static const routename="Restuarent_Dashboard";
//   @override
//   _Restuarent_DashboardState createState() => _Restuarent_DashboardState();
// }
//
// class _Restuarent_DashboardState extends State<Restuarent_Dashboard> {
//   int currentIndex = 1;
//   bool _isLoaded = false;
//
//   List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//
//   // int total_users=0;
//   int total_worker=0;
//   int total_revenue=0;
//   int service=0;
//
//
//   Future<double> fetch_total_revenue() async {
//     double sum=0;
//
//     CollectionReference collection =
//     FirebaseFirestore.instance.collection('Orders');
//
//     await collection.get().then((QuerySnapshot snapshot) {
//       snapshot.docs.forEach((element) {
//         print(element);
//         Map<dynamic, dynamic> fetcheddata =
//         element.data() as Map<dynamic, dynamic>;
//         double a=double.parse(fetcheddata['total_price'].toString());
//         sum=sum+a;
//
//       });
//
//     });
//
//     return sum;
//
//   }
//
//   Future update_active_status({String ? doc_id,bool ? status})async{
//     bool changed_status=!(status)!;
//     CollectionReference collection=FirebaseFirestore.instance.collection('Workers');
//
//     setState(() {
//       collection.doc(doc_id).update({
//         'active_status':changed_status
//       });
//     });
//
//
//   }
//
//   Future<List<Worker_Profile_Data>> fetch_workers() async {
//     total_worker=0;
//     List<Worker_Profile_Data> workers_list=[];
//     try{
//
//       CollectionReference collection =
//       FirebaseFirestore.instance.collection('Workers');
//
//       await collection.get().then((QuerySnapshot snapshot) {
//         snapshot.docs.forEach((element) {
//           print(element);
//           Map<dynamic, dynamic> fetcheddata =
//           element.data() as Map<dynamic, dynamic>;
//
//           workers_list.add(
//               Worker_Profile_Data(
//                 document_id: element.id,
//                 imageurl: fetcheddata['imageurl'],
//                 name: fetcheddata['Name'],
//                 active_status: fetcheddata['active_status'],
//               )
//           );
//         });
//       }).then((value) {
//         total_worker=workers_list.length;
//       });
//
//     }catch(e){
//       print(e);
//     }
//
//
//
//     return workers_list;
//   }
//
//   Future<List<BarMmodel>> fetch_total_users() async {
//
//     List<BarMmodel> users_data=[];
//     int dec=0;
//     int jan=0;
//     int feb=0;
//     int mar=0;
//     int apr=0;
//     int may=0;
//     int june=0;
//     int jul=0;
//     int aug=0;
//     int sept=0;
//     int oct=0;
//     int nov=0;
//
//     CollectionReference collection =
//     FirebaseFirestore.instance.collection('Orders');
//
//
//     await collection.get().then((QuerySnapshot snapshot) {
//
//       snapshot.docs.forEach((element) {
//
//         Map<String,dynamic>? fetcheddata = element.data() as Map<String,dynamic>;
//         DateTime pickeddate=DateTime.parse(fetcheddata['date']);
//         if(pickeddate.month==1){
//           jan++;
//         }
//         else if(pickeddate.month==2){
//           feb++;
//
//         } else if(pickeddate.month==3){
//           mar++;
//         } else if(pickeddate.month==4){
//           apr++;
//         } else if(pickeddate.month==5){
//           may++;
//         } else if(pickeddate.month==6){
//           june++;
//         } else if(pickeddate.month==7){
//           jul++;
//         } else if(pickeddate.month==8){
//           aug++;
//         } else if(pickeddate.month==9){
//           sept++;
//         } else if(pickeddate.month==10){
//           oct++;
//         }
//         else if(pickeddate.month==11){
//           nov++;
//         }
//         else if(pickeddate.month==12){
//           dec++;
//         }
//       });
//
//     }).then((value) {
//       print("step40");
//       users_data=[
//         BarMmodel("Dec", dec),
//         BarMmodel("Jan", jan),
//         BarMmodel("Feb",feb),
//         BarMmodel("Mar", mar),
//         BarMmodel("Apr", apr),
//         BarMmodel("May", may),
//         BarMmodel("Jun", june),
//         BarMmodel("Jul", jul),
//         BarMmodel("Aug", aug),
//         BarMmodel("Sept", sept),
//         BarMmodel("Oct", oct),
//         BarMmodel("Nov", nov),
//
//       ];
//
//
//     });
//
// print("users are "+users_data.toString());
//
//     return users_data;
//   }
//
// int earning=0;
//   late TooltipBehavior _tooltipBehavior;
//   Future<List<BarMmodel>> fetch_completed_data() async {
//
//     List<BarMmodel> users_data=[];
//     int dec=0;
//     int jan=0;
//     int feb=0;
//     int mar=0;
//     int apr=0;
//     int may=0;
//     int june=0;
//     int jul=0;
//     int aug=0;
//     int sept=0;
//     int oct=0;
//     int nov=0;
//
//
//     CollectionReference collection =
//     FirebaseFirestore.instance.collection('Orders');
//
//     await collection.get().then((QuerySnapshot snapshot) {
//
//       snapshot.docs.forEach((element) {
//         print("step element");
//         Map fetcheddata = element.data() as Map<String, dynamic>;
//         DateTime pickeddate=DateTime.parse(fetcheddata['date'].toString());
//         print("step after date"+pickeddate.month.toString());
//         if(pickeddate.month==12){
//           print("jaan");
//           double a=double.parse(fetcheddata['total_price'].toString());
//           dec=dec+a.toInt();
//
//         }
//
//         if(pickeddate.month==1){
//
//           double a=double.parse(fetcheddata['total_price'].toString());
//           print("u");
//           jan=jan+a.toInt();
//
//         print("done");
//         }
//
//         else if(pickeddate.month==2){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           feb=feb+a.toInt();
//         } else if(pickeddate.month==3){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           mar=mar+a.toInt();
//         } else if(pickeddate.month==4){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           apr=apr+a.toInt();
//         } else if(pickeddate.month==5){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           may=may+a.toInt();
//         } else if(pickeddate.month==6){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           june=june+a.toInt();
//         } else if(pickeddate.month==7){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           jul=jul+a.toInt();
//         } else if(pickeddate.month==8){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           aug=aug+a.toInt();
//         } else if(pickeddate.month==9){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           sept=sept+a.toInt();
//         }
//         else if(pickeddate.month==10){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           oct=oct+a.toInt();
//         }
//         else if(pickeddate.month==11){
//           double a=double.parse(fetcheddata['total_price'].toString());
//           nov=nov+a.toInt();
//         }
//
//       });
//
//     }).then((value) {
//
//       users_data=[
//         BarMmodel("Dec", dec),
//         BarMmodel("Jan", jan),
//         BarMmodel("Feb",feb),
//         BarMmodel("Mar", mar),
//         BarMmodel("Apr", apr),
//         BarMmodel("May", may),
//         BarMmodel("Jun", june),
//         BarMmodel("Jul", jul),
//         BarMmodel("Aug", aug),
//         BarMmodel("Sept", sept),
//         BarMmodel("Oct", oct),
//         BarMmodel("Nov", nov),
//       ];
//
//
//     });
//
//     return users_data;
//
//   }
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime now=DateTime.now();
//     DateTime dosra=DateTime.now();
//
//
//     print(dosra);
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, 100),
//         child: (ResponsiveLayout.isTinyLimit(context) ||
//             ResponsiveLayout.isTinyHeightLimit(context))
//             ? Container()
//             : AppBarWidget(),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height*0.1,
//             width: MediaQuery.of(context).size.width*0.97,
//             child: ListView(
//               children: [
//
//                 Card(
//                   color: Constants.purpleLight,
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.97,
//                     child: ListTile(
//                       //leading: Icon(Icons.sell),
//                       title: Text(
//                         "Total Users",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         "Users Registered on the app.",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       trailing: Chip(
//                         backgroundColor: Color(0xff53fdd7),
//                         label: Text(
//                           "",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Card(
//                   color: Constants.purpleLight,
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.97,
//                     child: ListTile(
//                       //leading: Icon(Icons.sell),
//                         title: Text(
//                           "Services Available",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         subtitle: Text(
//                           "Home Services for Users",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         trailing:   Chip(
//                           backgroundColor: Color(0xff53fdd7),
//                           label: Text(
//                             "0",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         )
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Constants.purpleLight,
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.97,
//                     child: ListTile(
//                       //leading: Icon(Icons.sell),
//                       title: Text(
//                         "Workers Registered",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         "Workers registered by Homease",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       trailing: Chip(
//                         backgroundColor: Color(0xff53fdd7),
//                         label: Text(
//                           total_worker.toString(),
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Constants.purpleLight,
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.97,
//                     child: ListTile(
//                       //leading: Icon(Icons.sell),
//                       title: Text(
//                         "Revenue Total",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         "revenue ",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       trailing: Chip(
//                         backgroundColor: Color(0xff53fdd7),
//                         label:    Chip(
//                           backgroundColor: Color(0xff53fdd7),
//                           label: Text(
//                             "0",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//
//               ],
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//
//
//           FutureBuilder(
//               future: fetch_total_users(),
//               builder: (context,AsyncSnapshot<List<BarMmodel>> snapshot){
//
//                 return snapshot.connectionState==ConnectionState.waiting?
//                 SpinKitCircle(color: Colors.black,):
//                 snapshot.hasData?
//                 Users_Bar_Chart(mylist: snapshot.data!):
//                 Text("No Data");
//               }),
//
//           FutureBuilder(
//               future: fetch_completed_data(),
//               builder: (context,AsyncSnapshot<List<BarMmodel>> snapshot){
//
//                 return snapshot.connectionState==ConnectionState.waiting?
//                 SpinKitCircle(color: Colors.black,):
//                 snapshot.hasData?
//                 SfChart(mylist: snapshot.data!):
//                 Text("No Data2");
//               }),
//
//
//           // FutureBuilder(
//           //     future: fetch_workers(),
//           //     builder: (context, AsyncSnapshot<List<Worker_Profile_Data>> snapshot){
//           //
//           //       return snapshot.connectionState==ConnectionState.waiting?
//           //       SpinKitCircle(color: Colors.black):
//           //       snapshot.hasData?
//           //       Padding(
//           //         padding: const EdgeInsets.only(
//           //             top: Constants.kPadding,
//           //             left: Constants.kPadding / 2,
//           //             right: Constants.kPadding / 2,
//           //             bottom: Constants.kPadding),
//           //         child: Card(
//           //           color: Constants.purpleLight,
//           //           elevation: 3,
//           //           shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(20)),
//           //           child: Column(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: [
//           //               Container(
//           //                 margin: EdgeInsets.only(left: 15,top: 10),
//           //                 child: Text(
//           //                   "Workers Availability",
//           //                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
//           //                 ),
//           //               ),
//           //               Column(
//           //                 children: List.generate(
//           //                   snapshot.data!.length,
//           //                       (index) => ListTile(
//           //                     leading: CircleAvatar(
//           //                       radius: 15,
//           //                       child: Text(
//           //                         snapshot.data![index].name!.substring(0, 1),
//           //                         style: TextStyle(color: Colors.white),
//           //                       ),
//           //                       backgroundColor: Color(0xfff8b250),
//           //                     ),
//           //                     title: Text(
//           //                       snapshot.data![index].name.toString(),
//           //                       style: TextStyle(color: Colors.white),
//           //                     ),
//           //                     trailing: Switch(value: snapshot.data![index].active_status!,   onChanged: (newvalue){
//           //
//           //                       update_active_status(doc_id: snapshot.data![index].document_id,status: snapshot.data![index].active_status!);
//           //
//           //                     }),
//           //                   ),
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ):
//           //       Text("No data");
//           //     })
//         ],
//
//       ),
//
//
//
//
//     );
//   }
// }
