import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/Screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';


class food_side_Horizontal_products extends StatelessWidget {
  @override
  static const IconData scissors = IconData(0xf7c9);
  List arg=[];
  List<Product> burger=[];
  List<Product> snacks=[];
  List<Product> drinks=[];
  List<Product> shakes=[];
  List<Product> pizza=[];

  Future<List<Product>> fetch_active() async {
    burger=[];
    snacks=[];
    drinks=[];
    shakes=[];
    pizza=[];
    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if(fetcheddata['status']==true){
          print("gaaaan");
          Product new_product= Product(
            title: fetcheddata['title'],
            price: fetcheddata['price'],
            quantity: 1,
            id: element.id,
            imageurl: fetcheddata['url'],
            status: fetcheddata['status'],
            category: fetcheddata['category'],
            product_doc_id: fetcheddata['product_doc_id'],
            restuarent_id:fetcheddata['restuarent_id'] ,
            subtitle:fetcheddata['description'] ,
            total: 0
          );
          newCategories.add(new_product);

          if(fetcheddata['category']=="Burgers"){
            burger.add(new_product);
          }
          else if(fetcheddata['category']=="Pizza"){
            pizza.add(new_product);
          }
          else if(fetcheddata['category']=="Snacks"){
            snacks.add(new_product);
          }
          else if(fetcheddata['category']=="Drinks"){
            drinks.add(new_product);
          }
          else if(fetcheddata['category']=="Shakes"){
            shakes.add(new_product);
          }
        }



      });
    });

    return newCategories;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(

        future: fetch_active(),
        builder: (context,AsyncSnapshot<List<Product>> snapshot){
      return
        snapshot.connectionState==ConnectionState.waiting?SpinKitCircle(color: Colors.black,):
        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 100,
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Category_Screen.routename,arguments:[burger,'Burger']);
                },
                child: Card(
                  shadowColor: Color.fromRGBO(102, 173, 39, 0.17),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                      height: 100,
                      width: 66,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(400)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child:  Image.network('https://freepngimg.com/download/burger/4-2-burger-png-file.png'),

                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Burgers")
                        ],
                      )),
                ),

              ),

              InkWell(
                onTap: () {
                  print(pizza);
                  Navigator.of(context).pushNamed(Category_Screen.routename,arguments:[pizza,'Pizza']);
                },
                child: Card(
                  color: Colors.white,
                  shadowColor: Color.fromRGBO(102, 173, 39, 0.17),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      height: 100,
                      width: 66,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Image.network('https://tse3.mm.bing.net/th?id=OIP.BEH8rpIxoiUt_AQDRmSYTAHaFY&pid=Api&P=0&w=243&h=178'),

                            )
                            ,
                          ),
                          SizedBox(height: 8,),
                          Text("Pizza")
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {

                  Navigator.of(context).pushNamed(Category_Screen.routename,arguments:[drinks,'Drinks']);
                },
                child: Card(

                  color: Colors.white,
                  shadowColor: Color.fromRGBO(102, 173, 39, 0.17),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      height: 100,
                      width: 66,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Image.network("https://www.nicepng.com/png/full/59-598258_drinks-cold-drink-glass-png.png")
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Cold Drniks")
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {

                  Navigator.of(context).pushNamed(Category_Screen.routename,arguments:[snacks,'Snacks']);

                },
                child: Card(
                  color: Colors.white,
                  shadowColor: Color.fromRGBO(102, 173, 39, 0.17),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      height: 100,
                      width: 66,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Image.network("https://tse2.mm.bing.net/th?id=OIP.As2eMssGl3S_d6dRwsEgOQHaKA&pid=Api&P=0&w=300&h=300")
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Snacks")
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Category_Screen.routename,arguments:[shakes,'Shakes']);

                },
                child: Card(
                  color: Colors.white,
                  shadowColor: Color.fromRGBO(102, 173, 39, 0.17),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      height: 100,
                      width: 66,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ),
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child:Image.network("https://theseasidebaker.com/wp-content/uploads/2015/07/IMG_5164.jpg"),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Shakes")
                        ],
                      )),
                ),
              ),



            ],
          ),
        ),
      );
    });
  }
}

