import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Enter_restuarent_name.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Restuarent_Dashboard.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart';
import 'package:discoveryourplate/hybrid_screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const routename = 'Wrapper';
  @override
  Widget build(BuildContext context) {

bool setup=false;
String docid='';

    final authservice = Provider.of<AuthService>(context);

    Future<bool> Check_position(String id) async {
      bool admin = false;
      CollectionReference collection =
      FirebaseFirestore.instance.collection('Users');

      await collection.get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((element) {
          print(element);
          Map<dynamic, dynamic> fetcheddata =
          element.data() as Map<dynamic, dynamic>;

          if (fetcheddata['userid'] == id) {

            if(fetcheddata['user_type']=='User'){
              username=fetcheddata['username'];

              admin=false;
            }
            else {
              docid=element.id;

              setup=fetcheddata['setup'];


              admin=true;

            }
          }
        });
      }).then((value) {
        if (admin == false) {

        } else {

        }
      });
      return admin;
    }

Future<bool> fetchrestauents() async {
  bool admin = false;
  CollectionReference collection =
  FirebaseFirestore.instance.collection('Restuarents');

  await collection.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((element) {
      print(element);
      Map<dynamic, dynamic> fetcheddata =
      element.data() as Map<dynamic, dynamic>;

      if (fetcheddata['userid'] == user_id) {
        restuarent_id=element.id;
        Restuarent_name=fetcheddata["Restuarent_name"].toString();
        print("Your Restuarent is "+Restuarent_name.toString());
        admin=true;
      }
    });
  });
  return admin;
}


    return StreamBuilder(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<MyUser?> snapshot) {
          final MyUser? user = snapshot.data;
          if(user!=null){
            user_id=user.uid;
          }
          return user == null ? Sign_In_Screen() :

          FutureBuilder(

              future: Check_position(user.uid),

              builder: (BuildContext context, AsyncSnapshot snapshot) {

                return !snapshot.hasData

                    ? SpinKitCircle(

                  color: Colors.white,

                )

                    :
                snapshot.data==true?
setup?
                FutureBuilder(
                    future:fetchrestauents(),
                    builder: (context,snapshot){
                  return
                    snapshot.connectionState==ConnectionState.waiting?
                        SpinKitCircle(color: Colors.black,):
                        snapshot.hasData?
                    Restuarent_Dashboard():
                  Text("");
                }):
                    Enter_Restuarent_name(doc_id: docid.toString(),)
                    :

                Home_Screen();

              });
        });
  }
}