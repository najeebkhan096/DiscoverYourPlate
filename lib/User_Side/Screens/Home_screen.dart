import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/restuarent_data.dart';
import 'package:discoveryourplate/User_Side/Screens/cart_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/feedback.dart';
import 'package:discoveryourplate/User_Side/Screens/search_restuarents.dart';
import 'package:discoveryourplate/User_Side/modal/feedback.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/horizontal_products.dart';
import 'package:discoveryourplate/User_Side/modal/popular_food.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Restuarent_data ? selected_restuarent;

class Home_Screen extends StatefulWidget {
  static const routename = "home_screen";
  static const IconData shopping_cart =
      IconData(0xe9de, fontFamily: 'MaterialIcons');

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool ispreesed = true;
  @override
  void initState() {
    // TODO: implement initState
    current_index = 0;
    super.initState();
  }

  double rating = 1;
  // String ? restuarent_name='';
Restuarent_data ? Current_Restuarent_data;
  TextEditingController notes_controller = TextEditingController();


  Future post_rating(
      {List<double>? rating,
      String? doc_id,
      List<Restuarent_feedback>? feedback}) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Restuarents');
      collection.doc(doc_id).update({
        'rating': rating,
        'feedback': feedback!
            .map((e) => {
                  'email': e.email.toString(),
                  'userimage': e.userimage.toString(),
                  'text': e.text.toString()
                })
            .toList()
      });
    } catch (e) {
      print(e.toString());
    }
  }



  Future<double> _getTheDistance({LatLng  ? initial,LatLng ? final_position}) async {
    double cal_distance = 0;

    double distanceImMeter = await Geolocator.distanceBetween(
      initial!.latitude,
      initial.longitude,
      final_position!.latitude,
      final_position.longitude,
    );

    var distance = distanceImMeter.round().toInt();
    print("distance in meter is " + distanceImMeter.toString());

    cal_distance = (distance / 1000);
    print("so the distance in km " + cal_distance.toString());
    return cal_distance;
  }

  Future<List<double>> fetch_rating(String doc) async {
    List<double> feedback = [];
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Restuarents');
    List<dynamic> fb = [];

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if (element.id == doc) {
          try {
            fb = fetcheddata['rating'];

            fb.forEach((element) {
              feedback.add(element);
            });
          } catch (error) {}
        }
      });
    });

    return feedback;
  }

  Future<List<Restuarent_feedback>> fetch_feedback(String doc) async {
    List<Restuarent_feedback> feedback = [];
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Restuarents');
    List<dynamic> fb = [];

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if (element.id == doc) {
          try {
            fb = fetcheddata['feedback'];

            fb.forEach((element) {
              feedback.add(Restuarent_feedback(
                  email: element['email'].toString(),
                  text: element['text'].toString(),
                  userimage: element['userimage'].toString()));
            });
          } catch (error) {}
        }
      });
    });

    return feedback;
  }

  void _show_feedback() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                content: SingleChildScrollView(
                  child: Container(
              decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      color: Color(0xffF5F5F5),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 1,
                      child: TextFormField(
                          maxLines: 5,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Feedback",
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            border: InputBorder.none,
                          ),
                          controller: notes_controller,
                          cursorColor: Colors.black),
                    ),
                    Text(
                      "Rating ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
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
                          rating = myrating;
                        });
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () async {

                        final FirebaseAuth auth = FirebaseAuth.instance;
                        User? currentuser = auth.currentUser;

                        auth.currentUser!.displayName;

                        List<double> myrating =
                            await fetch_rating(Current_Restuarent_data!.id.toString());
                        List<Restuarent_feedback> myfeedback =
                        await fetch_feedback(Current_Restuarent_data!.id.toString());

                        myrating.add(rating);
                        myfeedback.add(
                            Restuarent_feedback(
                            userimage: currentuser!.photoURL.toString(),
                            text: notes_controller.text,
                            email: currentuser.displayName.toString()));

                        post_rating(
                                doc_id: Current_Restuarent_data!.id.toString(),
                                rating: myrating,
                                feedback: myfeedback)
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
              ),
            ),
                )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notes_controller.dispose();
    super.dispose();
  }
Database _database=Database();

  bool fetched=false;
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  if(fetched==false){
     currentuser=await  _database.fetchprofiledata();
    print("doc is "+currentuser!.height.toString());

  }
  }

  @override
  Widget build(BuildContext context) {
    final device_size_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(50.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SFUIText-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.044,
                          ),

                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Restuarents')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return SpinKitCircle(
                                    color: Colors.black,
                                  );
                                if (!snapshot.hasData)
                                  return const Text('Loading...');
                                List<QueryDocumentSnapshot> precist =
                                    snapshot.data!.docs.toList();
                                final int messageCount = precist.length;
                                List<Restuarent_data> restuarents_data = [];

                                return precist.length == 0
                                    ? Container(
                                        child: Text(
                                        "No Restuarent",
                                        style: TextStyle(fontSize: 18),
                                      ))
                                    : Container(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xffDADADA),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                           Current_Restuarent_data!=null?
                                            Text(
                                              Current_Restuarent_data!.name.toString(),
                                              style: TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 16,
                                                  fontFamily:
                                                      'SFUIText-Regular'),
                                            ): Text(
                                             "Search Restuarent",
                                             style: TextStyle(
                                                 color: Color(0xffFFFFFF),
                                                 fontSize: 16,
                                                 fontFamily:
                                                 'SFUIText-Regular'),
                                           ),
                                            IconButton(
                                              icon: Icon(Icons.search),
                                              color: Colors.white,
                                              iconSize: 17,
                                              onPressed: () async{
                                                GoogleLocation _location = GoogleLocation();
                                                Position data = await _location.determinePosition();

                                                precist.forEach((element) async{
                                                  print("doc id is " + element.id.toString());

                                                  final distance= await  _getTheDistance(
                                                      initial: LatLng(data.latitude, data.longitude),
                                                      final_position: LatLng(element['latitude'],
                                                      element['longitude']));
if(element['status']==true){
  restuarents_data.add(Restuarent_data(
    status: element['status'],
    id: element.id,
    location: element['location'].toString(),
    name:
    element['Restuarent_name'].toString(),
    userid: element['userid'].toString(),
    image_url:
    element['image_url'].toString(),
    latitude: element['latitude'],
    longitude: element['longitude'],
    distance: distance,
  ));

}


                                                });
                                        showSearch(
                                                    context: context,
                                                    delegate: Serach_Restuarents(
                                                        suggestion2:
                                                        restuarents_data)).then((value) {

                                                          Restuarent_data data=value as Restuarent_data;
                                                          print("return value is "+ data.name.toString());

setState(() {
  Current_Restuarent_data=data;
  selected_restuarent=data;
  restuarents_data=[];
});

                                                        });

                                              },
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.17),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .shopping_basket_outlined,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(Cart_Screen
                                                            .routename);
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                          ],
                                        ),
                                      );
                              }),

                          SizedBox(
                            height: 15,
                          ),
                          //serach
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 80, right: 30),
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
                      width: 350,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Card(
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 30,
                        child: Center(child:
                        Text(
                          "Discover Your Plate",
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'ProximaNova-Regular',
                              fontWeight: FontWeight.w700,
                              fontSize: 31),
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  color: Color(0xff131010),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            food_side_Horizontal_products(rest_data: Current_Restuarent_data),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Popular Food",
                style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  fontSize: 24,
                  color: Color(0xff131010),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Recomended_Product_Screen(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Current_Restuarent_data==null?Text(""):

            Container(
              height: 50,
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  'Give  Feedback',
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontFamily: 'ProximaNova-Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.51),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color.fromRGBO(50, 205, 50, 2),
                textColor: Colors.white70,
                onPressed: () {
// Navigator.of(context).pushNamed(Feedback_Screen.routename);
                  _show_feedback();
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
          ],
        ),
      ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}

//
