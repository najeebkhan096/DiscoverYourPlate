import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

enum Purpose {
  gain,
  loss,
}

class Calculatebmr extends StatefulWidget {
  static const routename = "Calculatebmr";
  @override
  CalculatebmrState createState() => CalculatebmrState();
}

class CalculatebmrState extends State<Calculatebmr> {
  Gender? selectedGender=Gender.male;
  Purpose? selectedPurpose=Purpose.loss;

  double ? dailycalories=0;
  bool donebmr=false;

  // int height = 180;
  // int weight = 60;
  // int age = 20;
  double userheight = currentuser!.height!;
  double userweight = currentuser!.weight!;
  double userage = currentuser!.age!;
  double bmr = 0;
  double bmi=0;
  String bmiresult='';

  String bmrresult='0';
  @override
  void initState() {
    // TODO: implement initState
    Calculatebmr();
    super.initState();
  }

  bool lessthan=false;
  bool greaterthen=false;

  void Calculatebmr(){
    setState(() {
      // bmr = userweight / ((userheight*userheight)/10000);
      // bmrresult=bmr.toStringAsFixed(2);


      bmr=10*userweight+6.25*userheight-5*userage;
      if(selectedGender==Gender.male){
        bmr=bmr+5;
      }
      else{
        bmr=bmr-16;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('BMR\\BMI CALCULATOR', style: TextStyle(color: Colors.black)),
      ),

      body:

      donebmr?      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    selectedPurpose=Purpose.loss;
                  });
                },
                child: Container(
                  height: height * 0.13,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      color:
                      selectedPurpose==Purpose.loss?

                      Colors.black:mycolor
                      , borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.mars, color: Colors.white, size: 40),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Loose",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedPurpose=Purpose.gain;
                  });
                },
                child: Container(
                  height: height * 0.13,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      color:
                      selectedPurpose==Purpose.gain?
                      Colors.black:mycolor
                      , borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.venusMars,
                          color: Colors.white, size: 40),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Gain",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: height * 0.1,
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
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () async{

                if(selectedPurpose==Purpose.loss){
                  bmr=bmr-500;
                }
                else{
                  bmr=bmr+500;

                }
                Database _databasee=Database();
                await _databasee.updateBMI(bmr: bmr,bmi: bmi, userdoc: currentuser!.doc_id.toString(),
                  weight: userweight,
                  height:userheight,
                ).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("BMR Saved"),backgroundColor: Colors.teal,)
                  );

                  Navigator.of(context).pushReplacementNamed(Home_Screen.routename);

                });

                print("userid is "+currentuser!.doc_id.toString());
              },
            ),
          )



        ],
      ):

      ListView(
        children: <Widget>[
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    selectedGender=Gender.male;
                  });
                },
                child: Container(
                  height: height * 0.13,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      color:
                      selectedGender==Gender.male?

                      Colors.green:mycolor.withOpacity(0.7)
                      , borderRadius: BorderRadius.circular(10)),
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
              ),
              SizedBox(
                width: width * 0.05,
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedGender=Gender.female;
                  });
                },
                child: Container(
                  height: height * 0.13,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      color:
                      selectedGender==Gender.female?
                      Colors.green:mycolor.withOpacity(0.7)
                      , borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.venusMars,
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
                Calculatebmr();
                bmi = userweight / ((userheight*userheight)/10000);
                bmiresult=bmi.toStringAsFixed(2);

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
                  bmi = userweight / ((userheight*userheight)/10000);
                  bmiresult=bmi.toStringAsFixed(2);
                });
                Calculatebmr();

              }),


          //age
          SizedBox(
            height: height * 0.05,
          ),
          Center(
              child: Text(
                "Age",
                style: TextStyle(fontSize: 25),
              )),
          Center(
              child: Text(
                userage.toInt().toString()+" years",
                style: TextStyle(fontSize: 25),
              )),
          Slider(
              max: 150,
              activeColor: mycolor,
              value: userage,
              onChanged: (val) {
                setState(() {
                  userage   = val;
                  bmi = userweight / ((userheight*userheight)/10000);
                  bmiresult=bmi.toStringAsFixed(2);
                });
                Calculatebmr();
              }),

          bmi == 0

              ? Center(child: Text(""))

              : bmi > 25.5

              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BMR is "+bmr.toString(),style: TextStyle(fontSize: 25),),
              Text("BMI is "+bmi.toString(),style: TextStyle(fontSize: 25),),
              Text("Overweight",style: TextStyle(fontSize: 12.5),),
            ],
          )

              :

          bmi < 18.5?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BMR is "+bmr.toStringAsFixed(1),style: TextStyle(fontSize: 25),),
              SizedBox(height: height*0.025,),
              Text("BMI is "+bmi.toStringAsFixed(1),style: TextStyle(fontSize: 25),),
              SizedBox(height: height*0.025,),
              Text("Underweight",style: TextStyle(fontSize: 12.5),),
            ],
          ):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BMR is "+bmr.toStringAsFixed(1),style: TextStyle(fontSize: 25),),
              SizedBox(height: height*0.025,),
              Text("BMI is "+bmi.toStringAsFixed(1),style: TextStyle(fontSize: 25),),
              SizedBox(height: height*0.025,),
              Text("Normal",style: TextStyle(fontSize: 12.5),),
            ],
          )
          ,




          SizedBox(
            height: height * 0.025,
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
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () async{
                setState(() {
                  donebmr=true;
                });


              },
            ),
          )

        ],
      ),
    );
  }
}
