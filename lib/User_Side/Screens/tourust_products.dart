import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tourist_Products_Screen extends StatefulWidget {
  static const routename = "Tourist_Products_Screen";

  @override
  _Tourist_Products_ScreenState createState() => _Tourist_Products_ScreenState();
}

class _Tourist_Products_ScreenState extends State<Tourist_Products_Screen> {
  @override
  List<Product> categores_view_list = [];
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
  Future<List<Product>> fetch_active() async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
title=title.trim();
print("category is"+title.toString()+" and "+fetcheddata['category'].toString());
        if (fetcheddata['category'].toString().contains( title.toString())) {
print("done bro");
          Product new_product = Product(
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              id: element.id,
              imageurl: fetcheddata['url'],
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id: fetcheddata['product_doc_id'],
              restuarent_id: fetcheddata['restuarent_id'],
              subtitle: fetcheddata['description'],
              total: 0,
              sales: fetcheddata['sales'],
              Restuarent_name: fetcheddata['Restuarent_name'].toString()
          );
          newCategories.add(new_product);

        }

      });
    });

    return newCategories;
  }

  int _quantity = 0;
  String title='';
  Widget build(BuildContext context) {
   title= ModalRoute.of(context)!.settings.arguments  as String;
print("so title is "+title.toString());
if(title=="Burgers"){
  print("jaan");
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
      body: FutureBuilder(
        future: fetch_active(),
        builder: (BuildContext context,AsyncSnapshot<List<Product>> snapshot){
          return

            snapshot.connectionState==ConnectionState.waiting?
                SpinKitCircle(color: Colors.black,):
                snapshot.hasData?
            ListView.builder(
              itemBuilder: (ctx, index) {
                return


                  Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.only(
                            left: 10,),
                          child: Text("Restuarent name : "+
                              snapshot.data![index].Restuarent_name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima Nova Condensed Bold'),
                          ),
                        ),
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 07,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child:
                              snapshot.data![index].imageurl!.isEmpty
                                  ? Center(child: Text(""))
                                  : FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                      snapshot.data![index]
                                          .imageurl
                                          .toString())),
                            ),
                          ),
                          title: Text(
                            snapshot.data![index].title.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima Nova Condensed Bold'),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index]
                                    .subtitle
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: 'Proxima Nova Alt Regular.otf',
                                  color: Color(0xff131010),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.015,
                              ),
                              Text(
                                  'PKR${   snapshot.data![index].price.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SFUIText-Semibold')),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {


                              if(cart_list.any((element) => element.restuarent_id==snapshot.data![index].restuarent_id)){
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
                                  print("length is 0");
                                  if(cart_list[0].restuarent_id!=snapshot.data![index].restuarent_id){
                                    _showErrorDialog("You can not order from two different Resturents  at a time right now ");
                                  }
                                  else{
                                    cart_list.add(snapshot.data![index]);
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
                                  print("length is not 0");
                                  cart_list.add(snapshot.data![index]);
                                  Fluttertoast.showToast(
                                      msg: "Added to Cart",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                }
print("bol");
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),

                  ),
                );
              },
              itemCount:snapshot.data!.length):Text("No ");
        },
      ),
      bottomNavigationBar: User_Bottom_Navigation_Bar(),
    );
  }
}
