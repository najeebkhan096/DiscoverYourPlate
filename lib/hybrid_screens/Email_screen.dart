import 'package:discoveryourplate/hybrid_screens/enter_new_password.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart';

class Email_Screen extends StatefulWidget {
  static const routename = "enter_email_screen";

  @override
  _Email_ScreenState createState() => _Email_ScreenState();
}

class _Email_ScreenState extends State<Email_Screen> {
  bool isloading=false;
  // void sendOtp() async {
  //
  //
  //   ///Accessing the EmailAuth class from the package
  //   EmailAuth.sessionName = "Sample";
  //
  //   ///a boolean value will be returned if the OTP is sent successfully
  //   var data = await EmailAuth.sendOtp(receiverMail: _emailController.text);
  //   if (data) {
  //     ///have your error handling logic here, like a snackbar or popup widget
  //
  //     Navigator.of(context).pushReplacementNamed(OTP_Screen.routename);
  //   } else {
  //
  //   }
  // }
  //
  // ///create a bool method to validate if the OTP is true
  // bool verify() {
  //   return (EmailAuth.validate(
  //       receiverMail: _emailController.text)); //pass in the OTP typed in
  //   ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
  // }

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Enter Your Email",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: 'ProximaNova-Regular',
                  fontWeight: FontWeight.w700,
                  fontSize: 31),
            )),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(

                controller: _emailController,
                style: TextStyle(fontSize: 20),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email",labelStyle:  TextStyle(
                    color: Color(0xffABA5A5),
                    fontFamily: 'ProximaNova-Regular',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.51)),
                onTap: () {
                  // email = _emailController.text;
                },
                onSaved: (value) {
                  // setState(() {
                  //   email = _emailController.text;
                  // });
                },
                onFieldSubmitted: (value){
                  // setState(() {
                  //   email=_emailController.text;
                  // });
                },
              ),
            ),
            SizedBox(
              height: 60,
            ),
            isloading?CircularProgressIndicator():Text("")
          ],
        ),
      ),

      bottomNavigationBar: isloading?Text(""):Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: 298,
          child: RaisedButton(
            child: Text(
              'Verify',
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
              // setState(() {
              //   isloading=true;
              // });
              // sendOtp();
              Navigator.of(context).pushNamed(Enter_new_password.routename);
            },
          ),
        ),
      ),
    );
  }
}
