import 'dart:convert';
import 'dart:io';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/hybrid_screens/mapkey.dart';
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class Add_Worker_Screen extends StatefulWidget {
  static const routename = "Add_Worker_Screen";
  @override
  _Add_Worker_ScreenState createState() => _Add_Worker_ScreenState();
}

class _Add_Worker_ScreenState extends State<Add_Worker_Screen> {
  bool isloading = false;
  File? filename = null;
String worker_location='';
  Position ? _position;
  late UploadTask task;

  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  final picker = ImagePicker();

  void _show_camera_option() {
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

  Database database = Database();
  GoogleLocation _location = GoogleLocation();
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () async{
                _position=await  _location.determinePosition();
                worker_location=await _location.GetAddressFromLatLong(_position!);

                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }


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

  Future uploadFile() async {
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(filename!.path)}');
      await ref.putFile(filename!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageurl = value;
        });
      });
    } catch (error) {
      setState(() {
        isloading = false;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    try {
      setState(() {
        isloading=true;
      });
      uploadFile().then((value) {
        addworker().then((value) {

          _formKey.currentState!.reset();


          Fluttertoast.showToast(
              msg: "Worker is Added ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 28.0);
          _formKey.currentState!.reset();

          setState(() {
            filename = null;
            name='';
            cnic='';
            isloading = false;
          });

          Navigator.of(context).pop();
        });
      });
    } catch (error) {
      setState(() {
        isloading = false;
      });
    }

  }

  Future<List<String>> Fetch_mentor_data() async {

    List<String> mylist=[];

    print('ftech function');
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Categories');
    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        mylist.add(
            fetcheddata['Service_title']
        );

      });
    });

    return mylist;
  }
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? name;
  String ? cnic;


  String imageurl = '';

  void _show_picture_Dialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            RaisedButton(
              color: Colors.white54,
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ));
  }

  Future addworker() async {
    Map<String, dynamic> data = {
      'Name': name,
      'imageurl': imageurl,
      'active_status':true,
      'cnic':cnic,
      'restuarent_id':restuarent_id

    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Workers');
    collection.add(data).then((value) {

    });
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // bool   has_account= Provider.of<Profile_Data>(context,listen: false).Fetch_profile_data() as bool;
print("restuarent_id is "+restuarent_id.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Delivery Boy",style: TextStyle(color: Colors.black),),
          elevation: 0.3,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),


        body: SafeArea(
          child: Stack(
            children: [

              SingleChildScrollView(
                child: Column(

                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                    SingleChildScrollView(
                      child: Column(

                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          InkWell(
                            onTap: () {
                              _show_camera_option();
                            },
                            child: Container(
                                height: MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: filename == null
                                    ? Center(
                                    child: Text(
                                      "Select Photo",
                                      style: TextStyle(color: Colors.black45),
                                    ))
                                    : Container(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          image: FileImage(filename!),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                )
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),


                          Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      //name
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Colors.grey[300],
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Name ',
                                            fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Colors.black45,
                                                fontFamily:
                                                'ProximaNova-Regular',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.51),
                                          ),
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'invalid';
                                            }
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              name = value;
                                            });
                                          },
                                        ),
                                      ),

                                      //cnic
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Colors.grey[300],
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'CNIC ',
                                            fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Colors.black45,
                                                fontFamily:
                                                'ProximaNova-Regular',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.51),
                                          ),
                                          keyboardType:
                                          TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'invalid';
                                            }
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              cnic = value;
                                            });
                                          },
                                        ),
                                      ),

                                      //loc
                                      worker_location.isEmpty?Text(""):
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(child: Text(worker_location.toString()))
                                      ),





                                      RaisedButton(onPressed: ()async{
                                      _position=await  _location.determinePosition();
                                     worker_location=await _location.GetAddressFromLatLong(_position!);
                                     setState(() {

                                     });
                                      },child: Text("Get Location"),),

                                    ],
                                  ),
                                ),
                              )),



                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          isloading
                              ? SpinKitCircle(
                            color: Colors.black,
                          )
                              :
                          Container(
                            height:
                            MediaQuery.of(context).size.height * 0.06,
                            width:
                            MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Colors.blue,
                              ),
                              onPressed: () async{
                                print(filename);
                                if (filename == null) {
                                  _show_picture_Dialog("Please Select picture");
                                }

                                else if(worker_location==null || worker_location.isEmpty){
                                  _showErrorDialog('Select location');

                                }
                                else {
                                  _submit();
                                }
                              },
                              child: Text('SAVE',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
