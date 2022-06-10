import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/constants.dart';
import 'package:discoveryourplate/hybrid_screens/location.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:discoveryourplate/modals/foodcalories.dart';
import 'package:http/http.dart' as http;
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class Cart_Screen extends StatefulWidget {
  static const routename = "Cart_Screen";

  @override
  _Cart_ScreenState createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  bool isloading = false;
  Position ? data;
  Database database = Database();
  GoogleLocation _location = GoogleLocation();
  TextEditingController notes_controller = TextEditingController();
  String notes = '';
  double totalamount = 0;
  double requiredCalories=0;


  void _showErrorDialog(String msg) {
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

  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(Order new_order) async {
    try {
      paymentIntentData = await createPaymentIntent(
          totalamount.toString(), 'PKR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await stripe.Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'PAK',
              merchantDisplayName: 'Najeeb khan'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet(new_order);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(Order new_order) async {
    setState(() {
      isloading = false;
    });
    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
          parameters: stripe.PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("paid successfully"),
          backgroundColor: Colors.green,
        ));

        paymentIntentData = null;


        new_order.products!.forEach((element) {
          database.updateProductSale(docid:element.product_doc_id.toString(),count:element.sales);
          print("product sale is "+element.sales.toString());
          print("rest id  is "+element.product_doc_id.toString());
        });
        database.Add_Order(new_order)
            .then((value) {
          cart_list = [];
          Navigator.of(context).pop();
        });

      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(totalamount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51K1GtiD5z0PA4b4f4tH4F98PGYq0ZsR95vIQzpKUffJ4NNbutHLSJaqrgZ7KiC5wrj2hDCMZc5sItlmXrwaTqNY700vFOcMCoX',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(double amount) {
    final a = amount.toInt() * 100;
    return a.toString();
  }
  var maxLines = 5;

  calculatetotal() {
    totalamount = 0;
    cart_list.forEach((element) {
      setState(() {
        totalamount = totalamount + (element.price! * element.quantity!);
      });
    });
  }
double totalCalories=0;

  calculateCalories()async{
    totalCalories=0;
    cart_list.forEach((cartitem) async{
      double data=double.parse(cartitem.calories.toString());
      data=data*cartitem.quantity!;
    setState(() {
      totalCalories=totalCalories+data;

  if(currentuser!.BMI!<18.5){
    requiredCalories=2400-totalCalories;

  }
    });
    });


  }


  @override
  void initState() {
    // TODO: implement initState
    calculatetotal();
    calculateCalories();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final device_size_height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: cart_list.length == 0
            ? Center(
                child: Text(
                "No Item",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(

                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView.builder(
                          itemCount: cart_list.length,
                          itemBuilder: (context, index) {
                            return Container(

                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width*0.05,
                                  top: MediaQuery.of(context).size.height*0.02),
                              height: MediaQuery.of(context).size.height * 0.13,

                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print(cart_list[index]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                07,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.26,
                                        child:
                                            cart_list[index].imageurl!.isEmpty
                                                ? Center(child: Text(""))
                                                : FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Image.network(
                                                        cart_list[index]
                                                            .imageurl
                                                            .toString())),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  Container(

                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cart_list[index].title.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    'Proxima Nova Condensed Bold'),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(
                                            cart_list[index]
                                                .subtitle
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily:
                                                  'Proxima Nova Alt Regular.otf',
                                              color: Color(0xff131010),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015,
                                          ),
                                          Text(
                                              'PKR ${cart_list[index].price.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'SFUIText-Semibold')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.028,
                                  ),
                                  Container(

                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: MediaQuery.of(context).size.width *
                                        0.2,

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: mycolor),
                                              borderRadius:
                                                  BorderRadius.circular(3.92)),
                                          height: 18,
                                          width: 43,
                                          child: Center(
                                              child: Text(
                                            cart_list[index]
                                                .quantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 11, color: mycolor),
                                          )),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: mycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                height: 25,
                                                width: 25,
                                                child: InkWell(
                                                    onTap: () {
                                                      if (cart_list[index]
                                                              .quantity! >
                                                          0) {
                                                        cart_list[index]
                                                                .quantity =
                                                            cart_list[index]
                                                                    .quantity! -
                                                                1;
                                                        cart_list[index]
                                                            .total = (cart_list[
                                                                    index]
                                                                .quantity! *
                                                            cart_list[index]
                                                                .price!
                                                                .toDouble());
                                                        calculatetotal();
calculateCalories();
                                                      }
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )))),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: mycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                height: 25,
                                                width: 25,
                                                child: InkWell(
                                                    onTap: () {
                                                      cart_list[index]
                                                              .quantity =
                                                          cart_list[index]
                                                                  .quantity! +
                                                              1;
                                                      cart_list[index].total =
                                                          (cart_list[index]
                                                                  .quantity! *
                                                              cart_list[index]
                                                                  .price!
                                                                  .toDouble());
                                                      calculatetotal();
                    calculateCalories();
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            height: device_size_height * 0.031,
                            width: double.infinity,
                            child: Text(
                              "Order Notes:",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              color: Color(0xffF5F5F5),
                              height: device_size_height * 0.2,
                              width: MediaQuery.of(context).size.width * 1,
                              child: TextFormField(
                                  maxLines: maxLines,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "Notes",
                                    hintStyle: TextStyle(fontSize: 10),
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      notes = value!;
                                    });
                                  },
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      notes = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      notes = value;
                                    });
                                  },
                                  cursorColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Total",
                                  style: TextStyle(color: mycolor),
                                ),
                              ),
                              Text(totalamount.toStringAsFixed(2),
                                  style: TextStyle(color: mycolor)),
                            ],
                          ),
                          //   SizedBox(height: 35,),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Total Calories",
                                  style: TextStyle(color: mycolor),
                                ),
                              ),
                              Text(totalCalories.toStringAsFixed(2),
                                  style: TextStyle(color: mycolor)),
                            ],
                          ),
                          //   SizedBox(height: 35,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.teal,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "BMI",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text(currentuser!.BMI!.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            //   SizedBox(height: 35,),

                            currentuser!.BMI!<18.5?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                children: [
                                  Center(child: Text("You are underweight",style: TextStyle(
                                    color: Colors.white
                                  ),
                                  )),
                                  SizedBox(height: 10,),



                                ],
                              ),
                            ):
                            currentuser!.BMI!>24.5?
                            Text("You are Overweight"):

                            Text("Normal weight"),


                          ],
                        ),
                      ),
                    ),


                    requiredCalories<0?      Text("You exceeded the today Required Calories ",
                        style: TextStyle(color: mycolor)
                    ):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Today Required Calories",
                              style: TextStyle(color: mycolor),
                            ),
                          ),
                          Text(requiredCalories.toStringAsFixed(2),
                              style: TextStyle(color: mycolor)),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                    isloading
                        ? SpinKitCircle(
                            color: Colors.black,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: 298,
                              color: mycolor,
                              child: Center(
                                  child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isloading = true;
                                        });
                                        try {
    if (current_location!.isEmpty) {
      print("step10");
      MyGeolocation _location=MyGeolocation();
     data= await _location
          .determinePosition();
      current_location = await _location
          .GetAddressFromLatLong(data!);

      print("loc is "+current_location.toString());
      setState(() {
        isloading = false;
      });
    } else {
print("done");
MyGeolocation _location=MyGeolocation();
data= await _location
    .determinePosition();
current_location = await _location
    .GetAddressFromLatLong(data!);

setState(() {
  isloading = false;
});
      Order new_order = Order(
          products: cart_list,
          total_price: totalamount,
          date: DateTime.now().toString(),
          location: current_location,
          customer_latitude: data!.latitude,
          customer_longitude:
          data!.longitude,
          customer_name: username,
          notes: notes_controller.text,
          userid: user_id,
          order_status: 'ongoing',
          restuarent_id: cart_list[0].product_doc_id

      );
      print("step2");

      await makePayment(new_order).then((value) {
        setState(() {
          isloading = false;
        });
      });
    }

                                        } catch (error) {
                                          setState(() {
                                            isloading=false;
                                          });

                                        }
                                      },
                                      child: Text(
                                        "PLACE ORDER",
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.1),
                                      ))),
                            ),
                          ),


                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),


                  ],
                ),
              ),
      ),
    );
  }
}
