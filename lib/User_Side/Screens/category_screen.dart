import 'package:discoveryourplate/Chat/chatscreen.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Category_Screen extends StatefulWidget {
  static const routename = "Category_Screen";

  @override
  _Category_ScreenState createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  @override
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
  List<Product> categores_view_list = [];
  int _quantity = 0;
String title='';
  Widget build(BuildContext context) {
   List<dynamic> data = ModalRoute.of(context)!.settings.arguments  as List<dynamic>;
    try{
      title=data[1];
      categores_view_list=data[0];
    }catch(error){

    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title:
        Text(
          title.toString(),
          style: TextStyle(
            fontFamily: 'Proxima Nova Condensed Bold',
            fontSize: 20,
            color: Color(0xff131010),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: categores_view_list.isEmpty
                ? Text("No Item")
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 10,
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:  EdgeInsets.only(
                                    left: 10,),
                                child: Text("Restuarent name : "+
                                  categores_view_list[index].Restuarent_name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Proxima Nova Condensed Bold'),
                                ),
                              ),
                              SizedBox(height: 10,),

                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 1,
                                    width: MediaQuery.of(context).size.width * 0.26,
                                    child:
                                        categores_view_list[index].imageurl!.isEmpty
                                            ? Center(child: Text(""))
                                            : FittedBox(
                                                fit: BoxFit.fill,
                                                child: Image.network(
                                                    categores_view_list[index]
                                                        .imageurl
                                                        .toString())),
                                  ),
                                ),
                                title: Text(
                                  categores_view_list[index].title.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Proxima Nova Condensed Bold'),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categores_view_list[index]
                                          .subtitle
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Proxima Nova Alt Regular.otf',
                                        color: Color(0xff131010),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.005,
                                    ),
                                    Text(
                                        'PKR${categores_view_list[index].price.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SFUIText-Semibold')),


                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.005,
                                    ),
                                    Text(
                                    categores_view_list[index].size.toString()
                                    ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SFUIText-Semibold')),

                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {


                                    if(cart_list.any((element) => element.product_doc_id==categores_view_list[index].product_doc_id)
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
                                        if(cart_list[0].restuarent_id!=categores_view_list[index].restuarent_id){
                                          _showErrorDialog("You can not order from two different Resturents  at a time right now ");
                                        }
                                        else{
                                          cart_list.add(categores_view_list[index]);
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
                                        cart_list.add(categores_view_list[index]);
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
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(5)),
                                      height:
                                          MediaQuery.of(context).size.height * 0.05,
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      margin: EdgeInsets.only(bottom: 24),
                                      child: Center(
                                        child: Text(
                                          "Add to Cart",
                                          style: TextStyle(color: Colors.white,fontSize: 12.5),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        MyUser chatter=MyUser(
                                            categores_view_list[index].restuarent_id,
                                            '',
                                            categores_view_list[index].Restuarent_name
                                        );
                                        Database socialdatabase=Database();
                                        socialdatabase
                                            .getUserInfogetChats(
                                            categores_view_list[index].restuarent_id
                                        )
                                            .then((value) {
                                          print(
                                              "so final chatroom id is " +
                                                  value.toString());
                                          Navigator.of(context).pushNamed(
                                            Chat_Screen.routename,
                                            arguments: [
                                              value.toString(),
                                              chatter
                                            ],
                                          );

                                          //
                                        });
                                      },
                                      child:  Container(

                                          margin: EdgeInsets.only(right: 30),
                                          child:Icon(Icons.message,color: Colors.teal,)),
                                    ),

                                    InkWell(
                                      onTap: ()async{

                                        String url = "whatsapp://send?phone=${categores_view_list[index].restuarentphone}&text=Hello World!";

                                        await launch(url);
                                      },
                                      child: Container(

                                          margin: EdgeInsets.only(left: 30,right: 30),
                                          child:Icon(Icons.whatsapp,color: Colors.teal,)),
                                    ),
                                    InkWell(
                                      onTap: ()async{
                                        await  launch('tel://${categores_view_list[index].restuarentphone}');

                                      },
                                      child: Container(

                                          margin: EdgeInsets.only(left: 30,right: 30),
                                          child:Icon(Icons.phone,color: Colors.teal,)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),

                        ),
                      );
                    },
                    itemCount: categores_view_list.length),
          );
        },
      ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}
