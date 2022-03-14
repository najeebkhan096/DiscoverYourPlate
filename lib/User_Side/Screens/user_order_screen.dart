import 'dart:convert';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/widgets/cancelled_orders.dart';
import 'package:discoveryourplate/User_Side/widgets/completed_orders.dart';
import 'package:discoveryourplate/User_Side/widgets/inprogress.dart';

import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/item_data.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/services_category.dart';
import 'package:discoveryourplate/User_Side/widgets/ongoing_orders.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class User_Order_Screen extends StatefulWidget {
  static const routename = "User_Order_Screen";
  @override
  _User_Order_ScreenState createState() => _User_Order_ScreenState();
}

class _User_Order_ScreenState extends State<User_Order_Screen>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;
  @override

  late TabController _controller;


  @override
  void initState() {
    // TODO: implement initState
current_index=2;
    super.initState();

    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _controller.dispose();
  }
double rating=1;
  bool isloading = false;

  Future<List<double>> fetch_categories_feedback(String doc) async {
    List<double> feedback=[];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Categories');
    List<Service_Category> newCategories = [];

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if(element.id==doc){

          List<dynamic>fb= fetcheddata['feedback'];
            print("saad "+fb.toString());

            fb.forEach((element) {
              print(element);
              print(element.runtimeType);

              feedback.add(element);
            });

        }

      });
    });

    return feedback;
  }


  Future update_active_status({String ? doc_id,bool ? status})async{
    bool changed_status=!(status)!;
    CollectionReference collection=FirebaseFirestore.instance.collection('Workers');

    setState(() {
      collection.doc(doc_id).update({
        'active_status':changed_status
      });
    });


  }

  Future update_order_status() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Orders');
      collection.doc(_order_doc_id).update({
        'order_status': 'completed',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future post_feedback({List<double> ? feedback,String ? doc_id}) async {
    try {
      CollectionReference collection =
      FirebaseFirestore.instance.collection('Categories');
      collection.doc(doc_id).update({
        'feedback': feedback,
      });

    } catch (e) {
      print(e.toString());
    }

  }
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






  void _show_feedback() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rating ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (myrating) {
                      setState(() {
                        rating=myrating;
                      });
                      print(rating);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.035,),
                  RaisedButton(color: Colors.green,onPressed: ()async{
                    List<double> fetched_feedback=await fetch_categories_feedback(category_id!);
                    fetched_feedback.add(rating);
                    post_feedback(feedback: fetched_feedback,doc_id: category_id).then((value) => Navigator.of(context).pop());

                  },child: Text("Submit",style: TextStyle(color: Colors.white),),),

                ],
              ),
            )));
  }

  double final_total = 0;
  String? _order_doc_id;
  String ? category_id;
//   Map<String, dynamic>? paymentIntentData;
//   Future<void> makePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent(
//           final_total.toString(), 'PKR'); //json.decode(response.body);
//       // print('Response body==>${response.body.toString()}');
//       await stripe.Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: stripe.SetupPaymentSheetParameters(
//                   paymentIntentClientSecret:
//                       paymentIntentData!['client_secret'],
//                   applePay: true,
//                   googlePay: true,
//                   testEnv: true,
//                   style: ThemeMode.dark,
//                   merchantCountryCode: 'PAK',
//                   merchantDisplayName: 'ANNIE'))
//           .then((value) {});
//
//       ///now finally display payment sheeet
//
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }
//
//   displayPaymentSheet() async {
//     setState(() {
//       isloading = false;
//     });
//     try {
//       await stripe.Stripe.instance
//           .presentPaymentSheet(
//               parameters: stripe.PresentPaymentSheetParameters(
//         clientSecret: paymentIntentData!['client_secret'],
//         confirmPayment: true,
//       ))
//           .then((newValue) {
//         print('payment intent' + paymentIntentData!['id'].toString());
//         print(
//             'payment intent' + paymentIntentData!['client_secret'].toString());
//         print('payment intent' + paymentIntentData!['amount'].toString());
//         print('payment intent' + paymentIntentData.toString());
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         update_order_status();
//         _show_feedback();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("paid successfully"),
//           backgroundColor: Colors.green,
//         ));
//
//         paymentIntentData = null;
//       }).onError((error, stackTrace) {
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       });
//     } on stripe.StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//                 content: Text("Cancelled "),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }
//
// //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(final_total),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization':
//                 'Bearer sk_test_51K1GtiD5z0PA4b4f4tH4F98PGYq0ZsR95vIQzpKUffJ4NNbutHLSJaqrgZ7KiC5wrj2hDCMZc5sItlmXrwaTqNY700vFOcMCoX',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(double amount) {
//     final a = amount.toInt() * 100;
//     return a.toString();
//   }





  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),

        ),
        body: SingleChildScrollView(
          child: Container(
            height: height*1,
            child: Column(

              children: [
                Container(
                  margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                  height: height*0.08,
                  width: width*1,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffCCCCCC),width: 0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Container(

                    height: height*0.05,
                    width: width*0.85,
                    child: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Color(0xffCCCCCC),
                      indicatorColor: Colors.blue,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 10,
                          color: Color(0xff9099A6),
                          fontWeight: FontWeight.w600
                      ),
                      isScrollable: true,
                      indicatorPadding: EdgeInsets.only(top: 5),
                      indicatorWeight: height*0.004,
                      unselectedLabelStyle: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.w600
                      ),
                      controller: _controller,
                      tabs: [
                        Tab(
                          child: // Adobe XD layer: 'Emergency (6)' (text)
                          Text(
                            'Ongoing',
                            textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'InProgress',
                            textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'Completed',
                          ),
                        ),
                        Tab(
                          child: // Adobe XD layer: 'Second Opinion' (text)
                          Text(
                            'CANCELLED',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      //pending

                      Ongoing_Orders(),
                      //in progress
                    InProgress(),

                      //completed
                     Completed_Orders(),


                      //cancelled
                  Cancelled_Orders(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
      ),
    ));
  }
}
