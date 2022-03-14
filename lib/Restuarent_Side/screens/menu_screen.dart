import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Menu_Screen extends StatefulWidget {
  static const routename="Menu_Screen";

  @override
  _Menu_ScreenState createState() => _Menu_ScreenState();
}

class _Menu_ScreenState extends State<Menu_Screen> {

String category="Burgers";
String ? title;
String ? subtitle;
double ? price;

List<String> category_list=["Burgers","Pizza","Snacks","Drinks",'Shakes'];
File ? image_file;
bool isloading=false;

CollectionReference ? imgRef;
firebase_storage.Reference ? ref;
final picker = ImagePicker();

Future uploadFile() async {
  try{
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Admin Products/${Path.basename(image_file!.path)}');
    await ref!.putFile(image_file!).whenComplete(() async {
      await ref!.getDownloadURL().then((value) {
        imgRef = FirebaseFirestore.instance.collection('Products');
        imgRef!.add({
          'title':title,
          'description': subtitle,
          'price':price,
          'url': value,
          'category':category,
          'status':true,
          'restuarent_id':restuarent_id,

        }).then(
                (value) {
              setState(() {
                isloading=false;
              });
              Navigator.of(context).pop();
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

String ? _showErrorDialog(String msg)
{
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Accured'),
        content: Text(msg.toString()),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
  );
}

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }
  _formKey.currentState!.save();

  setState(() {
    isloading=true;
  });

  try {

    if(image_file!=null){
    uploadFile();
  }

else{

  setState(() {
    isloading=false;
  });

  _showErrorDialog("Please Select Image");

}
  } catch (error) {
    setState(() {
      isloading=false;
    });
    _showErrorDialog(error.toString());
  }
}

final GlobalKey<FormState> _formKey = GlobalKey();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Menu Item",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Card(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                     height: 60,
                    width: 60,
                    child: InkWell(onTap: (){

                    },child: image_file==null?InkWell(
                        onTap: (){
                          _show_my_Dialog();
                        },
                        child: Center(child: Text("No image selected"))):FittedBox(
                        fit: BoxFit.fill, child: Image.file(image_file!)),),
                  )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                Container(
                  margin: EdgeInsets.only(left: 15, top: 20, right: 20),
                  height: 58,
                  width: 336,
                  decoration: BoxDecoration(

                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: TextFormField(
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 25, right: 15),
                        hintText: "Enter Item Name",
                        hintStyle: TextStyle(color: Color(0xff999999))),
                  onSaved: (value){
title=value;
                  },
                    onFieldSubmitted: (value){

                      subtitle=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 20, right: 20),
                  height: 58,
                  width: 336,
                  decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: DropdownButton(
                    value: category,
                    onChanged: (value) {
                      setState(() {
                        category = value as String;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    items: category_list
                        .map((e) => DropdownMenuItem(
                        value: e, child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e),
                        )))
                        .toList(),
                  )

                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 20, right: 20),
                  height: 58,
                  width: 336,
                  decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 25, right: 15),
                        hintText: "Price",
                        hintStyle: TextStyle(color: Color(0xff999999))),
                    onSaved: (value){
                      price=double.parse(value as String);
                    },
                    onFieldSubmitted: (value){

                      price=double.parse(value as String);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 15, top: 20, right: 20),
                  height: 58,
                  width: 336,
                  decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: TextFormField(
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 25, right: 15),
                        hintText: "Enter description here",
                        hintStyle: TextStyle(color: Color(0xff999999))),
                    onSaved: (value){
                      subtitle=value;
                    },
                    onFieldSubmitted: (value){

                      subtitle=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),




              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                isloading?SpinKitCircle(color: Colors.black,):Container(
                  height: 50,
                  width: 298,
                  child: RaisedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontFamily: 'ProximaNova-Regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.51),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: mycolor,
                    textColor: Colors.white70,
                    onPressed: () {

_submit();
                    },
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
