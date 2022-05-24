import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

class CalculateBMI extends StatefulWidget {
  static const routename = "CalculateBMI";
  @override
  CalculateBMIState createState() => CalculateBMIState();
}

class CalculateBMIState extends State<CalculateBMI> {
  Gender? selectedGender;
  // int height = 180;
  // int weight = 60;
  // int age = 20;
  double userheight = currentuser!.height!;
  double userweight = currentuser!.weight!;
  double userage = 0;
  double bmi = 0;
  String bmiresult='0';
@override
  void initState() {
    // TODO: implement initState
      calculatebmi();
    super.initState();
  }


  void calculatebmi(){
    setState(() {
      bmi = userweight / ((userheight*userheight)/10000);
      bmiresult=bmi.toStringAsFixed(2);
    });
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
        title: Text('BMI CALCULATOR', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.13,
                width: width * 0.3,
                decoration: BoxDecoration(
                    color: mycolor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.mars, color: Colors.white, size: 40),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Male",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              Container(
                height: height * 0.13,
                width: width * 0.3,
                decoration: BoxDecoration(
                    color: mycolor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.marsAndVenus,
                        color: Colors.white, size: 40),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Female",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Center(
              child: Text(
            "Height",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            userheight.toInt().toString() + "cm",
            style: TextStyle(fontSize: 25),
          )),
          Slider(
              max: 500,
              activeColor: mycolor,
              value: userheight,
              onChanged: (val) {
                setState(() {
                  userheight = val;
                });
                calculatebmi();
              }),
          SizedBox(
            height: height * 0.05,
          ),
          Center(
              child: Text(
                "Weight",
                style: TextStyle(fontSize: 25),
              )),
          Center(
              child: Text(
                userweight.toInt().toString() + "kg",
                style: TextStyle(fontSize: 25),
              )),
          Slider(
              max: 150,
              activeColor: mycolor,
              value: userweight,
              onChanged: (val) {
                setState(() {
                  userweight   = val;
                });
              calculatebmi();
              }),
          bmi == 0

              ? Center(child: Text(""))

              : bmi > 25.5

                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BMI is "+bmi.toString(),style: TextStyle(fontSize: 25),),
                      Text("Overweight",style: TextStyle(fontSize: 12.5),),
                    ],
                  )

                  : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BMI is "+bmiresult.toString(),style: TextStyle(fontSize: 25),),
              Text("Underweight",style: TextStyle(fontSize: 12.5),),
            ],
          ),


          SizedBox(
            height: height * 0.05,
          ),


          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            height: MediaQuery.of(context).size.height * 0.07,
            width: double.infinity,
            child: RaisedButton(
              child: Text('Save',
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontFamily: 'ProximaNova-Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.51)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.lightGreen,
              textColor: Colors.white,
              onPressed: () async{

                Database _databasee=Database();
            await _databasee.updateBMI(bmi: bmi, userdoc: currentuser!.doc_id.toString(),
              weight: userweight,
              height:userheight
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("BMI Saved"),backgroundColor: Colors.teal,)
              );

              Navigator.of(context).pushReplacementNamed(Home_Screen.routename);

            });

          print("userid is "+currentuser!.doc_id.toString());
              },
            ),
          )

        ],
      ),
    );
  }
}
