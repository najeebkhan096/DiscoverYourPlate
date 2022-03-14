

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Derliveryboy/HomePage/worker_orders_status.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
class Worker_Log_in_Screen extends StatefulWidget {
  static const routename="Worker_Log_in_Screen";
  @override
  _Worker_Log_in_ScreenState createState() => _Worker_Log_in_ScreenState();
}

class _Worker_Log_in_ScreenState extends State<Worker_Log_in_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
String ? worker_cnic;
String ? worker_name;

  TextEditingController _passwordController = new TextEditingController();
  AuthService _auth = AuthService();
  String worker_id='';

  void _showErrorDialog(String msg, BuildContext context) {
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

  Future<bool> Check_CNIC(String cnic_id) async {
    bool exist = false;
    try{
      CollectionReference collection =
      FirebaseFirestore.instance.collection('Workers');
      await collection.get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((element) {
          print(element['cnic']);
          Map<dynamic, dynamic> fetcheddata =
          element.data() as Map<dynamic, dynamic>;

          if (fetcheddata['cnic'].toString() == cnic_id) {
            worker_id=element.id;
            worker_cnic=fetcheddata['cnic'].toString();
            worker_name=fetcheddata['Name'];
            restuarent_id=fetcheddata['restuarent_id'].toString();
            print(worker_cnic);
            exist=true;
          }
        });
      });

    }catch(e){
      print(e);
    }


    return exist;
  }


  bool isloading=false;
  bool is_register=false;
  bool visibilty=true;
  String cnic='';


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
    try{

      bool checked_cnic=await Check_CNIC(cnic);
      print("step2");
      if(checked_cnic){
        print("step3");
        setState(() {
          isloading=false;
        });
        Navigator.of(context).pushNamed(Worker_Order_Status_Screen.routename,arguments: {
          'cnoc':cnic,
              'name':worker_name
        });

      }
      else{
        print("step1");
       _showErrorDialog("No Delivery Boy with this CNIC", context) ;
        setState(() {
          isloading=false;
        });

      }

    } catch (error)
    {
      setState(() {
        isloading=false;
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

        children: [
          Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                "images/Sign_Up_bg.png",
                height: MediaQuery.of(context).size.height,
                // Now it takes 100% of our height
              ),
            ),
          ),


          SafeArea(
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.11),

                    child: Text(
                      "Log In",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold,fontSize: 30),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.14,),

                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          margin: EdgeInsets.only(left: 30,right: 30),
                          height: MediaQuery.of(context).size.height*0.3,
                          child: ListView(
                            children: [

                              //Email
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Enter CNIC',
                                    labelStyle:  TextStyle(
                                        color: Color(0xffABA5A5),
                                        fontFamily: 'ProximaNova-Regular',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.51)
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value)
                                {
                                  if(value!.isEmpty){
                                    return "*Required";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    cnic=value!;
                                  });
                                },
                                onChanged: (value){
                                  setState(() {
                                    cnic=value;
                                  });
                                },
                                onFieldSubmitted: (value){
                                  setState(() {
                                    cnic=value;
                                  });
                                },
                              ),

                            ],
                          ),
                        ),
                      )
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.035,),
                  isloading?SpinKitCircle(color: Colors.black,):Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: double.infinity,
                      child: RaisedButton(
                        child:
                        Text( 'Sign in', style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontFamily: 'ProximaNova-Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.51)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.35),
                        ),
                        color: Colors.blue[800],
                        textColor: Colors.white, onPressed: () {
                        _submit();



                      },),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}