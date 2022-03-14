import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/stock_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:discoveryourplate/User_Side/Screens/Edit_Profile_Screen.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/restuarent_modal.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/hybrid_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:geolocator/geolocator.dart';

import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

class User_Profile_Screen extends StatefulWidget {
  static const routname = "User_Profile_Screen";

  @override
  _User_Profile_ScreenState createState() => _User_Profile_ScreenState();
}

bool _switch = true;

class _User_Profile_ScreenState extends State<User_Profile_Screen> {
  Future<User_Data?> fetchprofiledata() async {
    User_Data? user;

    CollectionReference collection =
        FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
            element.data() as Map<String, dynamic>;

        if (fetcheddata['userid'] == user_id) {
          user = User_Data(
            email: fetcheddata['email'].toString(),
            name: fetcheddata['username'].toString(),
            doc_id: element.id,
            admin: fetcheddata['admin'],
            imageurl: fetcheddata['imageurl'].toString(),
            phone: fetcheddata['phone_no'].toString(),
            uid: user_id,
          );
        }
      });
    }).then((value) {});

    return user;
  }
@override
  void initState() {
    // TODO: implement initState
   current_index=3;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [



          FutureBuilder(
            future: fetchprofiledata(),
            builder:
                (BuildContext context, AsyncSnapshot<User_Data?> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? SpinKitCircle(
                      color: Colors.black,
                    )
                  : snapshot.hasData
                      ? snapshot.data!.imageurl.toString().isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.imageurl.toString()),
                                ),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                Text(
                                  snapshot.data!.name.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25),
                                ),
                                SizedBox(
                                  height: height * 0.006,
                                ),
                                Text(snapshot.data!.email.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16))
                              ],
                            )
                          : CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.green,
                              child: Text(
                                "No Image",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )
                      : Text("");
            },
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Edit_profile_Screen.routename);
            },
            leading: Text(
              "Edit Profile",
              style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2E3034)),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xff2E3034),
            ),
          ),

          ListTile(
            onTap: () {},
            leading: Text(
              "Feedback",
              style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2E3034)),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xff2E3034),
            ),
          ),


          ListTile(
            onTap: () async {
              FirebaseAuth _auth = await FirebaseAuth.instance;
              _auth.signOut().then((value) {
                restuarent_id = '';
                Navigator.of(context).pushReplacementNamed(Wrapper.routename);
              });
            },
            leading: Text(
              "Log Out",
              style: TextStyle(
                  fontFamily: 'SFUIText-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2E3034)),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xff2E3034),
            ),
          ),
        ],
      ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}
