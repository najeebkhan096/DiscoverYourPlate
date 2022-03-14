import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Restuarent_Dashboard.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;

import '../../User_Side/modal/constants.dart';




class Enter_Restuarent_name extends StatefulWidget {
  static const routname="Enter_Restuarent_name";
  final String ? doc_id;
  Enter_Restuarent_name({this.doc_id});

  @override

  _Enter_Restuarent_nameState createState() => _Enter_Restuarent_nameState();

}

class _Enter_Restuarent_nameState extends State<Enter_Restuarent_name> {
  bool isloading = false;
  String restuarent_name='';
  double ? _latitide;
  double ? _longitude;
  String _loc='';
  Database database = Database();
  GoogleLocation _location = GoogleLocation();
  File ? image_file;
  CollectionReference ? imgRef;
  firebase_storage.Reference ? ref;
  final picker = ImagePicker();

  Future uploadFile() async {
    try{
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Restuarent banners/${Path.basename(image_file!.path)}');
      await ref!.putFile(image_file!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          imgRef = FirebaseFirestore.instance.collection('Restuarents');
          imgRef!.add({
            'Restuarent_name':restuarent_name,
            'userid': user_id,
            'image_url':value,
            'latitude':_latitide,
            'longitude':_longitude,
            'location':_loc.toString(),
            'status':true

          });
        });
      });
    }
    catch(error){
      setState(() {
        isloading=false;
      });
    }

  }

  String ? _showErrorDialog(BuildContext context, String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Accured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }




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
  void _show_ic_Dialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Center(child: Text("Select Banner"))
              ),
            ));
  }

  Future getfilename(int choice) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        image_file = File(image!.path);
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        image_file = File(image!.path);
      });
    }
  }




  final GlobalKey<FormState> _formKey = GlobalKey();
  String existance_key='';




  Future<void> _submit() async
  {
    if(!_formKey.currentState!.validate())
    {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
  if(image_file!=null){

    if( _longitude==null ||  _longitude==null || _loc.isEmpty){
 setState(() {
   isloading=false;
 });
      _showErrorDialog(context,'Location is not fetched');
    }
    else{
      print("step1");
      uploadFile().then((value) async{
        setState(() {
          isloading=false;
        });
        await database.UpdateRestuarent_Setup_Status(widget.doc_id.toString()).then((value) {
          Navigator.of(context).pushReplacementNamed(Restuarent_Dashboard.routename);
        });

      });
    }

  }
  else{
    setState(() {
      isloading=false;
    });
    _show_ic_Dialog();
  }
  }





  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Restuarent profile",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[

          ],
        ),
        body: Card(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 20, right: 20),
                height: 58,

                width: 336,
                decoration: BoxDecoration(
                    color: Color(0xffF9F9F9),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 25, right: 15),
                        hintText: "Enter Restuarent Name",
                        hintStyle: TextStyle(color: Color(0xff999999))),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Restuarent name';
                      }
                      return null;
                    },
                    onSaved: (value){
                      restuarent_name=value!;
                    },
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15,right: 20),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Banner images",
                        style: TextStyle(
                            color: Color(0xff2E3034),
                            fontFamily: 'SFUIText-Regular',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mycolor, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                        height: 36,
                        width: 138,
                        child: InkWell(
                          onTap: (){
_show_my_Dialog();
                          },
                          child: Center(
                              child: Text(
                                "Change",
                                style: TextStyle(fontSize: 11, color: mycolor),
                              )),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 20),
                height: 142,
                width: 336,

                child: image_file==null?Center(child: Text("No image selected")):FittedBox(
                    fit: BoxFit.fill, child: Image.file(image_file!)),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: 100,
                child: RaisedButton(
                  child: Text(
                    'Get Location',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: mycolor,
                  textColor: Colors.white,
                  onPressed: () async{
                     Position data=await _location
                        .determinePosition();
                     print(data.toString());
                      _loc = await _location
                         .GetAddressFromLatLong(data);
                    _latitide=data.latitude;
                    _longitude=data.longitude;
                      _loc = await _location
                         .GetAddressFromLatLong(data);

                  },
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              isloading?SpinKitCircle(color: Colors.black,):

              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.8,
                child:RaisedButton(
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: mycolor,
                  textColor: Colors.white,
                  onPressed: () {
_submit();

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}