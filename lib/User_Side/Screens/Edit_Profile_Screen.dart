import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/clipper.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as cloudstore;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';



class Edit_profile_Screen extends StatefulWidget {
  static const routename = "Edit_profile_Screen";
  @override
  _Edit_profile_ScreenState createState() => _Edit_profile_ScreenState();
}

class _Edit_profile_ScreenState extends State<Edit_profile_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  auth.
  AuthService _auth = auth.AuthService();
  bool isloading=false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
    try{

    }catch(error){

    }
    if(filename==null){
      UpdateData(docid!).then((value) {
        setState(() {
          isloading=false;
        });
        Navigator.of(context).pop();
      });
    }
    else{
      uploadFile(docid!).then((value) {

        setState(() {
          isloading=false;
        });
        Navigator.of(context).pop();
      });
    }


  }


  Future<User_Data?> fetchprofiledata() async {
    User_Data? user;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;

        if (fetcheddata['userid'] == user_id) {
          docid=element.id;
          username=fetcheddata['username'].toString();
          phone_no=fetcheddata['phone_no'].toString();

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




  Future UpdateData(String doc) async {

    Map<String, dynamic> data = {
      'username': username,
      'imageurl':image_url,
      'phone_no':phone_no,
    };

    cloudstore.
    CollectionReference collection =
    cloudstore.
    FirebaseFirestore.instance.collection('Users');
    collection.doc(doc).update(data);
  }

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

  String ? email;

  String ? username;
  String ? phone_no;
  String ? docid;

  final picker = ImagePicker();

  void _show_my_Dialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      getfilename(1).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      getfilename(2).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.green,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            )));
  }

  File ? filename;

  Future getfilename(int choice) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        filename = File(image!.path);
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        filename = File(image!.path);
      });
    }
  }

  String ? image_url='';
  cloudstore.
  CollectionReference ? imgRef;
  firebase_storage.Reference ? ref;


  Future uploadFile(String doc) async {

    try{
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('post/${Path.basename(filename!.path)}');
      await ref!.putFile(filename!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          image_url=value;
          UpdateData(doc);
        });
      });
    }
    catch(error){
      setState(() {
        isloading=false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      ListView(
        children: [
          FutureBuilder(
              future: fetchprofiledata(),
              builder: (BuildContext context,AsyncSnapshot<User_Data?> snpashot){
                return
                  snpashot.connectionState==ConnectionState.waiting?
                  Text(""):
                  snpashot.hasData?

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          color: Colors.green,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              filename!=null?
                              InkWell(
                                onTap: (){
                                  _show_my_Dialog();
                                },
                                child: CircleAvatar(
                                  backgroundImage: FileImage(File(filename!.path)),
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                ),
                              ):
                              (snpashot.data!.imageurl==null || snpashot.data!.imageurl!.isEmpty || snpashot.data!.imageurl=='null')?
                              InkWell(
                                onTap: (){
                                  _show_my_Dialog();
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                    size: 45,
                                  ),
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                ),
                              ):
                              InkWell(
                                onTap: (){
                                  _show_my_Dialog();
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(snpashot.data!.imageurl.toString()),
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Form(
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              height: MediaQuery.of(context).size.height * 0.38,
                              child: Column(
                                children: [
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.7,
                                            child: Center(
                                              child: TextFormField(
                                                initialValue: snpashot.data!.name,

                                                style: TextStyle(color: Colors.black),
                                                decoration: InputDecoration(
                                                    hintText: 'Username',
                                                    hintStyle: TextStyle(
                                                        color: Color(0xffABA5A5),
                                                        fontFamily: 'ProximaNova-Regular',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.51),
                                                    border: InputBorder.none),
                                                validator: (value) {
                                                  if (value!.isEmpty ) {
                                                    return 'invalid ';
                                                  }
                                                  return null;
                                                },

                                                onSaved: (value) {

                                                  username = value;

                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.02,
                                  ),
                                  //Password
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 120,
                                            child: Center(
                                              child: TextFormField(
                                                initialValue: snpashot.data!.phone,

                                                keyboardType: TextInputType.number,
                                                style: TextStyle(color: Colors.black),
                                                decoration: InputDecoration(
                                                    hintText: 'Phone no',
                                                    hintStyle: TextStyle(
                                                        color: Color(0xffABA5A5),
                                                        fontFamily: 'ProximaNova-Regular',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.51),
                                                    border: InputBorder.none),

                                                validator: (value) {
                                                  if(value!.isEmpty){
                                                    return 'invalid';
                                                  }

                                                  return null;
                                                },
                                                onSaved: (value) {

                                                  phone_no = value;

                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.02,
                                  ),
                                ],
                              ),
                            )),
                      ),


                    ],
                  ):Text("");
              }),

          isloading?SpinKitCircle(color: Colors.black,):
          InkWell(
            onTap: (){


_submit();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green
              ),
              margin: EdgeInsets.only(left: 20,right: 30),
              child: Center(
                child: Text('Update',style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ProximaNova-Regular',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.51),),
              ),
            ),
          ),
        ],
      ),


    );
  }
}