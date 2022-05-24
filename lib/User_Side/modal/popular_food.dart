import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Recomended_Product_Screen extends StatelessWidget {
  Future<List<Product>> fetch_active() async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        print("step1");
        if (fetcheddata['status'] == true) {
          print("gaaaan"+fetcheddata['Restuarent_name'].toString());
          Product new_product = Product(
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              id: element.id,
              imageurl: fetcheddata['url'],
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id: element.id,
              restuarent_id: fetcheddata['restuarent_id'],
              subtitle: fetcheddata['description'],
              total: 0,
              sales: fetcheddata['sales'],
              Restuarent_name: fetcheddata['Restuarent_name'].toString()
          );
          newCategories.add(new_product);
        }

      });
    }).then((value) {
      newCategories.sort((a,b)=>a.sales!.toInt() .compareTo(b.sales!.toInt() ));
      newCategories=newCategories.reversed.toList();
    });

    return newCategories;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,

      child: FutureBuilder(
        future: fetch_active(),
        builder: (BuildContext context,AsyncSnapshot<List<Product>> snapshot){
          return
            snapshot.connectionState==ConnectionState.waiting?SpinKitCircle(color: Colors.black,):
                snapshot.hasData?
                    snapshot.data!.length>0?

            ListView.builder(itemBuilder: (ctx,index){
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 10),
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: MediaQuery.of(context).size.height * 0.19,
                      padding: EdgeInsets.only(bottom: 21),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              NetworkImage(snapshot.data![index].imageurl.toString()),
                             fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10))),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.02,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child:Text(
              snapshot.data![index].title.toString(),
                        style: TextStyle(
                          fontFamily: 'Proxima Nova Condensed Bold',
                          color: Color(0xff131010),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                  ),
                ],
              ),
            );
          },

            itemCount: snapshot.data!.length,
            scrollDirection: Axis.horizontal,

          ):Text(""):Text("No Item");
        },
      )

    );
  }
}
