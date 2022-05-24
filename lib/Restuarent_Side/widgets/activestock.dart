import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Database/database.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Active_Stock extends StatefulWidget {
  @override
  State<Active_Stock> createState() => _Active_StockState();
}

class _Active_StockState extends State<Active_Stock> {
  Database database=Database();

  List arg = [];

  List<Product> burger = [];

  List<Product> snacks = [];

  List<Product> drinks = [];

  List<Product> shakes = [];

  List<Product> pizza = [];

  Future<List<Product>> fetch_active() async {
    burger = [];
    snacks = [];
    drinks = [];
    shakes = [];
    pizza = [];
    List<Product> newCategories = [];
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if (fetcheddata['status'] == true && restuarent_id==restuarent_id) {

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
              total: 0);
          newCategories.add(new_product);

          if (fetcheddata['category'] == "Burgers") {
            burger.add(new_product);
          } else if (fetcheddata['category'] == "Pizza") {
            pizza.add(new_product);
          } else if (fetcheddata['category'] == "Snacks") {
            snacks.add(new_product);
          } else if (fetcheddata['category'] == "Drinks") {
            drinks.add(new_product);
          } else if (fetcheddata['category'] == "Shakes") {
            shakes.add(new_product);
          }
        }
      });
    });
    print("love");
    return newCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetch_active(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapashot) {
            return snapashot.connectionState == ConnectionState.waiting
                ? SpinKitCircle(
                    color: Colors.black,
                  )
                : snapashot.hasData
                    ? snapashot.data!.length > 0
                        ? ListView(
              children: [
                ExpansionTile(
                    title: Text(
                      'Bergurs',
                    ),
                    children: List.generate(
                        burger.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 8),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height *
                                0.15,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      07,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.26,
                                  child: burger[index]
                                      .imageurl!
                                      .isEmpty
                                      ? Center(child: Text(""))
                                      : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                          burger[
                                          index]
                                              .imageurl
                                              .toString())),
                                ),
                              ),
                              title: Text(
                                burger[index]
                                    .title
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    'Proxima Nova Condensed Bold'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    burger[index]
                                        .subtitle
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                  ),
                                  Text(
                                      'PKR ${burger[index].price.toString()}',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'SFUIText-Semibold')),
                                ],
                              ),
                              trailing:PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: (){
                                        print(burger[index].id.toString());
                               database.updateProductStatus(status: false,docid: burger[index].id.toString()).then((value) {
                                 setState(() {

                                 });
                               });
                                      },
                                      child: Text("Non Active"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      onTap: (){
                                        database.deleteProduct(burger[index].id.toString()).then((value) {
                                        setState(() {

                                        });
                                        });

                                        },
                                      child: Text("Delete"),
                                      value: 2,
                                    )
                                  ]
                              )
                            ),

                          ),
                        ))),
                ExpansionTile(
                    title: Text(
                      'Pizza',
                    ),
                    children: List.generate(
                        pizza.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 8),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height *
                                0.15,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      07,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.26,
                                  child: pizza[index]
                                      .imageurl!
                                      .isEmpty
                                      ? Center(child: Text(""))
                                      : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                          pizza[
                                          index]
                                              .imageurl
                                              .toString())),
                                ),
                              ),
                              title: Text(
                                pizza[index]
                                    .title
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    'Proxima Nova Condensed Bold'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pizza[index]
                                        .subtitle
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                  ),
                                  Text(
                                      'PKR ${pizza[index].price.toString()}',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'SFUIText-Semibold')),
                                ],
                              ),
                              trailing:PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: (){
                                        print(pizza[index].id.toString());
                                        database.updateProductStatus(status: false,docid: pizza[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });
                                      },
                                      child: Text("Non Active"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      onTap: (){
                                        database.deleteProduct(pizza[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });

                                      },
                                      child: Text("Delete"),
                                      value: 2,
                                    )
                                  ]
                              )
                            ),

                          ),
                        ))),
                ExpansionTile(
                    title: Text(
                      'Snacks',
                    ),
                    children: List.generate(
                        snacks.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 8),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height *
                                0.15,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      07,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.26,
                                  child: snacks[index]
                                      .imageurl!
                                      .isEmpty
                                      ? Center(child: Text(""))
                                      : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                          snacks[
                                          index]
                                              .imageurl
                                              .toString())),
                                ),
                              ),
                              title: Text(
                                snacks[index]
                                    .title
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    'Proxima Nova Condensed Bold'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snacks[index]
                                        .subtitle
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                  ),
                                  Text(
                                      'PKR ${snacks[index].price.toString()}',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'SFUIText-Semibold')),
                                ],
                              ),
                              trailing:PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: (){
                                        print(snacks[index].id.toString());
                                        database.updateProductStatus(status: false,docid: snacks[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });
                                      },
                                      child: Text("Non Active"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(  onTap: (){
                                      database.deleteProduct(snacks[index].id.toString()).then((value) {
                                        setState(() {

                                        });
                                      });

                                    },
                                      child: Text("Delete"),
                                      value: 2,
                                    )
                                  ]
                              )
                            ),

                          ),
                        ))),
                ExpansionTile(
                    title: Text(
                      'Cold Drinks',
                    ),
                    children: List.generate(
                        drinks.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 8),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height *
                                0.15,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      07,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.26,
                                  child: drinks[index]
                                      .imageurl!
                                      .isEmpty
                                      ? Center(child: Text(""))
                                      : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                          drinks[
                                          index]
                                              .imageurl
                                              .toString())),
                                ),
                              ),
                              title: Text(
                                drinks[index]
                                    .title
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    'Proxima Nova Condensed Bold'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    drinks[index]
                                        .subtitle
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                  ),
                                  Text(
                                      'PKR ${drinks[index].price.toString()}',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'SFUIText-Semibold')),
                                ],
                              ),
                              trailing:PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: (){
                                        print(drinks[index].id.toString());
                                        database.updateProductStatus(status: false,docid: drinks[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });
                                      },
                                      child: Text("Non Active"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(  onTap: (){
                                      database.deleteProduct(drinks[index].id.toString()).then((value) {
                                        setState(() {

                                        });
                                      });

                                    },
                                      child: Text("Delete"),
                                      value: 2,
                                    )
                                  ]
                              )
                            ),

                          ),
                        ))),
                ExpansionTile(
                    title: Text(
                      'Shakes',
                    ),
                    children: List.generate(
                        shakes.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 8),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height *
                                0.15,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      07,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.26,
                                  child: shakes[index]
                                      .imageurl!
                                      .isEmpty
                                      ? Center(child: Text(""))
                                      : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                          shakes[
                                          index]
                                              .imageurl
                                              .toString())),
                                ),
                              ),
                              title: Text(
                                shakes[index]
                                    .title
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    'Proxima Nova Condensed Bold'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shakes[index]
                                        .subtitle
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                  ),
                                  Text(
                                      'PKR ${shakes[index].price.toString()}',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'SFUIText-Semibold')),
                                ],
                              ),
                              trailing:PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: (){
                                        print(shakes[index].id.toString());
                                        database.updateProductStatus(status: false,docid: shakes[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });
                                      },
                                      child: Text("Non Active"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      onTap: (){
                                        database.deleteProduct(shakes[index].id.toString()).then((value) {
                                          setState(() {

                                          });
                                        });

                                      },
                                      child: Text("Delete"),
                                      value: 2,
                                    )
                                  ]
                              )
                            ),

                          ),
                        ))),
              ],
            )
                        : ListView(
              children: [
                ExpansionTile(
                    title: Text(
                      'Bergurs',
                    ),
                    children: []),
                ExpansionTile(
                    title: Text(
                      'Pizza',
                    ),
                    children: []
                ),
                ExpansionTile(
                    title: Text(
                      'Snacks',
                    ),
                    children: []),
                ExpansionTile(
                    title: Text(
                      'Cold Drinks',
                    ),
                    children: []),
                ExpansionTile(
                    title: Text(
                      'Shakes',
                    ),
                    children: []),
              ],
            )
                    : Center(child: Text("loading"));
          }),
    );
  }
}
