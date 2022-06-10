import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/modals/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DetailScreen extends StatefulWidget {
  static const routename = "DetailScreen";

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
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
  Product ? currntpost;
  @override

  Widget build(BuildContext context) {
    currntpost=ModalRoute.of(context)!.settings.arguments as Product;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: ListView(
            children: [
              Container(
                height: height*0.3,
                width: width*1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(currntpost!.imageurl!)
                    )
                ),
              ),

              SizedBox(height: height*0.025,),

              Center(child: Text(currntpost!.title!,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: mycolor),))
              , SizedBox(height: height*0.025,),
              Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

                  child: Text(currntpost!.subtitle.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,)
                    ,))
              , SizedBox(height: height*0.025,),



              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currntpost!.size.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: mycolor),)
                    ,Text(currntpost!.price.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)



                  ],
                ),
              ),



              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Container(
                width: double.infinity,
                height: height*0.075,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.025, right: MediaQuery.of(context).size.height*0.025,),
                child: RaisedButton(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontFamily: 'ProximaNova-Regular',
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.indigo,
                  textColor: Colors.white70,
                  onPressed: () {

                    if(cart_list.any((element) => element.product_doc_id==currntpost!.product_doc_id)
                    ){
                      Fluttertoast.showToast(
                          msg: "Already Added to Cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else{
                      if(cart_list.length>0){
                        if(cart_list[0].restuarent_id!=currntpost!.restuarent_id){
                          _showErrorDialog("You can not order from two different Resturents  at a time right now ");
                        }
                        else{
                          cart_list.add(currntpost!);
                          Fluttertoast.showToast(
                              msg: "Added to Cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                      else{
                        cart_list.add(currntpost!);
                        Fluttertoast.showToast(
                            msg: "Added to Cart",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);

                      }

                    }


                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),



            ],
          )
      ),
    );
  }
}
