import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Derliveryboy/addworker.dart';
import 'package:discoveryourplate/Derliveryboy/manageworkers.dart';
import 'package:discoveryourplate/Derliveryboy/remove_worker.dart';
import 'package:discoveryourplate/Derliveryboy/view_worker.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/stock_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/User_Side/modal/restuarent_modal.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/wrapper.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:geolocator/geolocator.dart';

import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';


class Restuarent_Profile_screen extends StatefulWidget {
  static const routname = "Restuarent_Profile_screen";

  @override
  _Restuarent_Profile_screenState createState() =>
      _Restuarent_Profile_screenState();
}



class _Restuarent_Profile_screenState extends State<Restuarent_Profile_screen> {
  bool _switch = true;
      Database database=Database();

  Future<Restuarent_Modal?> fetchprofiledata() async {
    Restuarent_Modal ? user;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Restuarents');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;

        if (fetcheddata['userid'] == user_id) {
          restuarent_id=element.id;
         user=Restuarent_Modal(
           user_id: user_id,
           restuarent_doc_id:element.id ,
           restuarent_image: fetcheddata['image_url'],
           restuarent_name: fetcheddata['Restuarent_name'],
           status: fetcheddata['status'],
         );
       _switch=fetcheddata['status'];

        }

      });
    }).then((value) {

    });

    return user;
  }


  @override
  void initState() {
    // TODO: implement initState
    restuarent_current_index=3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
      body: FutureBuilder(
        future: fetchprofiledata(),
        builder: (context,AsyncSnapshot<Restuarent_Modal?> snapshot){
          return
            snapshot.connectionState==ConnectionState.waiting?
                SpinKitCircle(color: Colors.black,):
            ListView(
            children: [
              snapshot.data!.restuarent_image!.isEmpty?
              CircleAvatar(
                radius: 40,
                child: CircleAvatar(
                  backgroundImage:AssetImage("images/a.png"),
                  radius: 38,
                ),
              ):
              CircleAvatar(
                radius: 40,
                backgroundColor: mycolor,
                child: CircleAvatar(
                  backgroundImage:NetworkImage(snapshot.data!.restuarent_image.toString()),

                  radius: 36,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(child: Text (snapshot.data!.restuarent_name.toString())),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ListTile(
                onTap: (){

                },
                leading: Text(
                  "Edit profile",
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

                leading: Text(
                  "Open /Close",
                  style: TextStyle(
                      fontFamily: 'SFUIText-Regular',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff2E3034)),
                ),
                trailing: Switch(
                  thumbColor: _switch?MaterialStateProperty.all(Colors.white70):MaterialStateProperty.all(Colors.black12),
                  trackColor: _switch?MaterialStateProperty.all(mycolor):MaterialStateProperty.all(Colors.white),
                  value: _switch,
                  onChanged: (value) {

                      _switch=value;

      database.updateRestuarentStatus(status: value).then((value) {
        setState(() {

        });
      });
                    },
                ),
              ),
              ListTile(
                onTap: ()async{
Navigator.of(context).pushNamed(Manage_Worker_Screen.routename);
                },
                leading: Text(
                  "Delivery Boy",
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
                onTap: () {
                  Navigator.of(context).pushNamed(Stock_Screen.routename);
                },
                leading: Text(
                  "Food Stock",
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
                onTap: ()async{
                  FirebaseAuth _auth = await FirebaseAuth.instance;
                  _auth.signOut().then((value) {
                    restuarent_id = '';
                    Navigator.of(context)
                        .pushReplacementNamed(Wrapper.routename);
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
          );
        },
      ),
      bottomNavigationBar: Restuarent_Bottom_Navigation_Bar(),
    );
  }
}
