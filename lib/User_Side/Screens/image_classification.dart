import 'package:discoveryourplate/User_Side/Screens/tourust_products.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class ImageClassification extends StatefulWidget {
  static const routename="ImageClassification";


  @override
  _ImageClassificationState createState() => _ImageClassificationState();
}

class _ImageClassificationState extends State<ImageClassification> {
  bool loading=false;
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
  List output=[];
  File ? filename;
  classifyImage(File image)async{
    var recognitions =await Tflite.runModelOnImage(
        path: image.path,   // required
        imageMean: 127.5,   // defaults to 117.0
        imageStd: 127.5,  // defaults to 1.0
        numResults: 2,    // defaults to 5
        threshold: 0.5,   // defaults to 0.1
        asynch: true// defaults to true
    );
    setState(() {
      loading=true;
      output=recognitions!;
    });
  }
  Future getfilename(int choice) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      if(image==null) return null;
      setState(() {
        loading=true;
        filename = File(image.path);

      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        loading=true;
        filename = File(image!.path);

      });

    }
    classifyImage(filename!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadmodal().then((value) {
      setState(() {
        loading=false;
      });
    });
  }

  Future loadmodal()async{

    String? res = await Tflite.loadModel(
      model: "images/model_unquant.tflite",
      labels: "images/labels.txt",
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("Tourist",style: TextStyle(color: Colors.black),),

      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset('images/IC_BG.jpg',fit: BoxFit.fill),
       Container(
         margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
         height: MediaQuery.of(context).size.height*1,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             Container(
               height: 50,
               width: double.infinity,
               child: RaisedButton(
                 child: Text(
                   'Choose Picture',
                   style: TextStyle(
                       color: Color(0xffFFFFFF),
                       fontFamily: 'ProximaNova-Regular',
                       fontWeight: FontWeight.w400,
                       fontSize: 14.51),
                 ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
                 color: Color.fromRGBO(50, 205, 50, 2),
                 textColor: Colors.white70,
                 onPressed: () {
                   _show_my_Dialog();
                                    },
               ),
             ),

             SizedBox(height:  MediaQuery.of(context).size.height*0.02),

             filename==null?
             Text(""):
             Container(
               width: MediaQuery.of(context).size.width*0.5,
               height: MediaQuery.of(context).size.height*0.3,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 image: DecorationImage(
                   image: FileImage(File(filename!.path))
                 )
               ),
             ),
             SizedBox(height:  MediaQuery.of(context).size.height*0.02),

             output.length>0?
             Column(
               children: [
                 Container(
                   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.height*0.05),

                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.green,
                     ),
                     child: Text("${output[0]['label']}".replaceAll(RegExp(r'[0-9]'),''),style: TextStyle(color: Colors.white),)),
                 Container(
                   height: 50,
                   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,),

                   width: double.infinity,
                   child: RaisedButton(
                     child: Text(
                       'Search for this item',
                       style: TextStyle(
                           color: Color(0xffFFFFFF),
                           fontFamily: 'ProximaNova-Regular',
                           fontWeight: FontWeight.w400,
                           fontSize: 14.51),
                     ),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                     ),
                     color: Color.fromRGBO(50, 205, 50, 2),
                     textColor: Colors.white70,
                     onPressed: () {
                       Navigator.of(context).pushNamed(
                           Tourist_Products_Screen.routename,
                           arguments:"${output[0]['label']}".replaceAll(RegExp(r'[0-9]'),'' ));
                     },
                   ),
                 ),
               ],
             ):Text("")

           ],
         ),
       ),
        ],
      ),
    bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}
