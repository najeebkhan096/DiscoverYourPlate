import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/widgets/bottom_navigation_bar.dart';
import 'package:discoveryourplate/User_Side/modal/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Category_Screen extends StatefulWidget {
  static const routename = "Category_Screen";

  @override
  _Category_ScreenState createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  @override
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
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 8),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 07,
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
                                      0.015,
                                ),
                                Text(
                                    '\$${categores_view_list[index].price.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFUIText-Semibold')),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                if(cart_list.contains(categores_view_list[index])){
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
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.13,
//                             width: MediaQuery.of(context).size.width * 0.94,
//                             child: Row(
//                               children: [
//                                 InkWell(
//                                   onTap: (){
//                                     print(categores_view_list[index].id);
//                                   },
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(6),
//                                     child: Container(
//                                       height: MediaQuery.of(context).size.height * 07,
//                                       width: MediaQuery.of(context).size.width * 0.26,
//                                       child: categores_view_list[index].imageurl!
//                                           .isEmpty?Center(child: Text("")):FittedBox(
//                                           fit: BoxFit.fill,
//                                           child: Image.network(
//                                               categores_view_list[index].imageurl.toString())),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width * 0.025,
//                                 ),
//                                 Container(
//                                   height: MediaQuery.of(context).size.height * 1,
//                                   width: MediaQuery.of(context).size.width * 0.4,
//                                   child: FittedBox(
//                                     fit: BoxFit.contain,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           categores_view_list[index].title.toString(),
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily:
//                                               'Proxima Nova Condensed Bold'),
//                                         ),
//                                         SizedBox(
//                                           height: MediaQuery.of(context).size.height *
//                                               0.01,
//                                         ),
//                                         Text(
//                                           categores_view_list[index].subtitle.toString(),
//                                           style: TextStyle(
//                                             fontFamily:
//                                             'Proxima Nova Alt Regular.otf',
//                                             color: Color(0xff131010),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: MediaQuery.of(context).size.height *
//                                               0.015,
//                                         ),
//                                         Text(
//                                             '\$${categores_view_list[index].price.toString()}',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'SFUIText-Semibold')),
//
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width * 0.028,
//                                 ),
//
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width * 0.055,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//
// cart_list.add(
//   categores_view_list[index]
// );
// Fluttertoast.showToast(
//     msg: "Added to Cart",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.CENTER,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//     fontSize: 16.0
// );
//
//                                   },
//                                   child: Container(
//
//                                       decoration: BoxDecoration(
//                                         color: Colors.green,
//                                         borderRadius: BorderRadius.circular(5)
//                                       ),
//                                       height: MediaQuery.of(context).size.height*0.04,
//                                       width: MediaQuery.of(context).size.width*0.18,
//                                       margin: EdgeInsets.only(bottom: 24),
//                                       child: Text("Add to Cart",style: TextStyle(color: Colors.white),)
//
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
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
