import 'package:discoveryourplate/Derliveryboy/HomePage/worker_login.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart';
import 'package:discoveryourplate/hybrid_screens/otp_screen.dart';
import 'package:discoveryourplate/hybrid_screens/sign_up_screen.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Sign_In_Screen extends StatefulWidget {
  static const routname = "Sign_In_Screen";
  @override
  _Sign_In_ScreenState createState() => _Sign_In_ScreenState();
}

class _Sign_In_ScreenState extends State<Sign_In_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
bool showconf=false;
  bool isloading=false;

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
  AuthService _auth=AuthService();
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
    try {
      final  User result =await  _auth.signInWithEmailAndPassword(email!, password!);

    } catch (error) {
      setState(() {
        isloading=false;
      });
      _showErrorDialog(error.toString());
    }
  }
  String ? email;
  String ? password;

  @override

  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset('images/welcome_bg.jpg'),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 80),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //image
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset("images/a.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Text(
                            "Discover Your Plate",
                            style: TextStyle(
                                color: Color(0xff2C2627),
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w700,
                                fontSize: 31),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sign in to continue",
                            style: TextStyle(
                                color: Color(0xff2C2627),
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          Form(
key:_formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.21,
                                  child: ListView(
                                    children: [
                                      //Email
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Email ',
                                          labelStyle: TextStyle(
                                              color: Color(0xffABA5A5),
                                              fontFamily: 'ProximaNova-Regular',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.51),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,

                                      onSaved: (value){
                                          email=value;
                                      },
                                        onFieldSubmitted: (value){
                                          email=value;
                                        },
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'invalid';
                                          }
                                          return null;

                                        },
                                      ),

                                      //Password
                                      TextFormField(
                                        decoration: InputDecoration(
                                            suffixIcon: showconf?InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    showconf=!showconf;
                                                  });

                                                },
                                                child  : Icon(Icons.visibility_off,size: 16,color: Color(0xff9099A6),)):InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    showconf=!showconf;
                                                  });

                                                },
                                                child: Icon(Icons.visibility,size: 16,color: Color(0xff9099A6),)),
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                                color: Color(0xffABA5A5),
                                                fontFamily:
                                                    'ProximaNova-Regular',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.51)),
                                        obscureText: showconf,
onSaved: (value){
               password=value;
},
                                        onFieldSubmitted: (value){
                                          password=value;
                                        },
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'invalid';
                                          }
                                          return null;

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      InkWell(
                        onTap: () {
Navigator.of(context).pushReplacementNamed(OTP_Screen.routename);
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(
                                color: mycolor,
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.69)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                
                     isloading?SpinKitCircle(color: Colors.black,):
                     Container(
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text(
                                  'SIGN IN',
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
_submit();
                                },
                              ),
                            ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account?  "),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(Sign_up_Screen.routename);
                              },
                              child: Text("Sign up",
                                  style: TextStyle(
                                    color: Color.fromRGBO(50, 205, 50, 2),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),



                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(""),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(Worker_Log_in_Screen.routename);
                              },
                              child: Text("Delivery Boy Log in",
                                  style: TextStyle(
                                    color: Color.fromRGBO(50, 205, 50, 2),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}