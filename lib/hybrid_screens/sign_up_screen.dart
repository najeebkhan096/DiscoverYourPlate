import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart';
import 'package:discoveryourplate/hybrid_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_up_Screen extends StatefulWidget {
static const routename="Sign_up_Screen";

  @override
  _Sign_up_ScreenState createState() => _Sign_up_ScreenState();
}
final GlobalKey<FormState> _formKey = GlobalKey();

class _Sign_up_ScreenState extends State<Sign_up_Screen> {
  bool isloading=false;
List<String> categ=['User','Restuarent'];
String selected_categ='User';

  String ? email;
  String ? password;
  String confpass='';
  String ? username;
  String ? phone_no;
bool showpass=true;
bool showconf=true;

  AuthService _auth = AuthService();
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
    print("stepn2"+email.toString()+password.toString());
    try {
      final  User result = await _auth.registerWithEmailAndPassword(email!, password!);
      print(result.uid);

      result.updateDisplayName(username.toString());
      adduser(result.uid).then((value) async {
        Fluttertoast.showToast(
            msg: "Account is Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        FirebaseAuth _auth= await FirebaseAuth.instance;
        _auth.signOut().then((value) {
          Navigator.of(context).pushReplacementNamed(Wrapper.routename);
        });

      });
    } catch (error) {
      setState(() {
        isloading=false;
      });
      _showErrorDialog(error.toString());
    }
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
  Future adduser(String userid) async {
    bool choice=false;
    if(selected_categ=="User"){
      choice=false;
    }
    else{
      choice=true;
    }
    Map<String, dynamic> data = {
      'username': username,
      'email': email,
      'userid':userid,
      'admin':choice,
      'imageurl':'',
      'phone_no':phone_no,
      'setup':false,
      'userid':userid,
      'user_type':selected_categ,
      'BMI':0.0,
      'weight':0.0,
      'height':0.0,
      'age':0.0

    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.add(data);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: FittedBox(fit: BoxFit.fill,child: Image.asset('images/welcome_bg.jpg')),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20,top: 65),
                child: Column(
                  children:<Widget> [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: Image.asset("images/a.png"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Signup",
                            style:  TextStyle(
                                color: Color(0xff2C2627),
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w700,
                                fontSize: 31),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.53,
                            child: ListView(
                              children: [

                                //name
                                TextFormField(
                                  decoration: InputDecoration(labelText: '*Name',
                                      labelStyle:  TextStyle(
                                          color: Color(0xffABA5A5),
                                          fontFamily: 'ProximaNova-Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.51)
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'invalid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    username=value;
                                  },
                                ),

                                //Email
                                TextFormField(
                                  decoration: InputDecoration(labelText: '*Email ',
                                      labelStyle:  TextStyle(
                                          color: Color(0xffABA5A5),
                                          fontFamily: 'ProximaNova-Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.51)
                                  ),
                                  keyboardType: TextInputType.emailAddress,
validator: (value){
                                    if(value!.isEmpty){
                                      return 'invalid';
                                    }
                                    return null;
},   onSaved: (value){
                                  email=value;
                                },
                                ),

                                //Phone Number
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: '*Phone Number',
                                      labelStyle:  TextStyle(
                                          color: Color(0xffABA5A5),
                                          fontFamily: 'ProximaNova-Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.51)
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'invalid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    phone_no=value;
                                  },
                                ),

                                //Password
                                TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      password=val.toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value != null) {
                                      bool passValid = RegExp(
                                          "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                                          .hasMatch(value);
                                      if (value.isEmpty) {
                                        return '*Required';
                                      }
                                      if (value.length < 5) {
                                        return '*Password is too short';
                                      }

                                      if (!passValid) {
                                        return 'Weak password\n[Must be between 8 and 30 characters, with at least\n one uppercase letter, a symbol and a number digit]';
                                      }
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(labelText: '*Password',
                                      suffixIcon: showpass?InkWell(
                                          onTap: (){
                                            setState(() {
                                              showpass=!showpass;
                                            });

                                          },
                                          child  : Icon(Icons.visibility_off,size: 16,color: Color(0xff9099A6),)):InkWell(
                                          onTap: (){
                                            setState(() {
                                              showpass=!showpass;
                                            });

                                          },
                                          child: Icon(Icons.visibility,size: 16,color: Color(0xff9099A6),)),
                                      labelStyle:  TextStyle(
                                          color: Color(0xffABA5A5),
                                          fontFamily: 'ProximaNova-Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.51)
                                  ),
                                  obscureText: showpass,


                                  onSaved: (value){
                                    password=value;
                                  },
                                ),


                                //Confirm password
                                TextFormField(
                                  onSaved: (val){
                                    confpass=val.toString();
                                  },
                                  onChanged: (val){
confpass=val;
                                  },
                                  decoration: InputDecoration(labelText: '*Confirm Password',
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
                                      labelStyle:  TextStyle(
                                          color: Color(0xffABA5A5),
                                          fontFamily: 'ProximaNova-Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.51)
                                  ),
                                  obscureText: showconf,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'invalid';
                                    }
                                    else if(confpass!=password){
                                      return 'Does not match';
                                    }
                                    return null;
                                  },

                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                                Container(
                                    width: MediaQuery.of(context).size.width * 1,

                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4),
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(6)),
                                    padding: EdgeInsets.only(left: 10),
                                    child: DropdownButton(
                                      hint: Text(
                                        "Category",
                                      ),
                                      value: selected_categ,
                                      onChanged: (value) {
                                        setState(() {
                                          selected_categ = (value as String?)!;
                                        });
                                      },
                                      icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      items:categ.map(
                                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                                          .toList(),
                                    )
                                ),
                              ],
                            ),
                          ),
                        )
                    ),



                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),




                    isloading?SpinKitCircle(color: Colors.black,):Padding(
                      padding: const EdgeInsets.only(left: 7,right: 25),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        width: double.infinity,
                        child: RaisedButton(
                          child:
                          Text( 'SIGN UP', style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'ProximaNova-Regular',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.51)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.35),
                          ),
                          color: Colors.lightGreen,
                          textColor: Colors.white, onPressed: () {
_submit();
                        },),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?  "),
                        InkWell(onTap: (){
                          // Navigator.of(context).pushReplacementNamed(food_side_Sign_in_screen.routname);
                          //

                        },child: Text("Sign in",style: TextStyle(  color: Colors.lightGreen))),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
