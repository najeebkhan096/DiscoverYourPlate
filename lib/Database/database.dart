import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
class Database{
  Future Add_Order(Order myorder) async {


    Map<String, dynamic> data = {
      'products': myorder.products!.map(
              (e) => {
            'title': e.title,
            'subtitle': e.subtitle,
            'price': e.price,
            'total_price':e.total,
            'quantity':e.quantity,
                'imageurl':e.imageurl,
                'prodoct_id':e.product_doc_id

          }).toList(),
      'notes': myorder.notes,
      'total_price': myorder.total_price,
      'date': myorder.date,
      'userid':user_id,
      'location':myorder.location,
      'customer_latitude':myorder.customer_latitude,
      'customer_longitude':myorder.customer_longitude,
      'customer_name':myorder.customer_name,
      'order_status':'ongoing',
    };
    print("ek baars");

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.add(data);

  }



  CollectionReference ? imgRef;
  firebase_storage.Reference ? ref;

  Future<void> UpdateRestuarent_Setup_Status(String doc) async {

    Map<String, dynamic> data = {
      'setup': true,

    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(doc).update(data);
  }

  Future<List<Order>> fetch_ongoing_orders() async {
    List<Order> myorders = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];

        if (fetcheddata['order_status'] != null) {
          if (fetcheddata['order_status'] == "ongoing") {
            print("khan"+user_id.toString());

              myorders.add(Order(
                location: fetcheddata['location'],
                customer_name: fetcheddata['customer_name'],
                notes: fetcheddata['notes'],
                date: fetcheddata['date'],
                customer_longitude: fetcheddata['customer_latitude'],
                customer_latitude: fetcheddata['customer_longitude'],
                total_price: fetcheddata['total_price'],
                userid: fetcheddata['userid'].toString(),
                order_id: element.id,
                order_status: fetcheddata['order_status'],
                products:  myproducts
                    .map(
                      (e) => Product(
                      price: e['price'],
                      quantity: e['quantity'],
                      title: e['title'].toString(),
                      subtitle: e['subtitle'].toString(),
                      imageurl: e['imageurl'].toString()

                  ),
                )
                    .toList(),
              ),

              );


          }
        }
      });
    });

    print("list is" + myorders.length.toString());
    return myorders;
  }

  Future<List<Order>> fetch_in_progress_orders() async {
    List<Order> myorders = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];

        if (fetcheddata['order_status'] != null) {
          if (fetcheddata['order_status'] == "in_progress" ||
              fetcheddata['order_status'] == "On_going") {
            if (user_id == fetcheddata['userid']) {

              myorders.add(Order(
                location: fetcheddata['location'],
                customer_name: fetcheddata['customer_name'],
                notes: fetcheddata['notes'],
                date: fetcheddata['date'],
                customer_longitude: fetcheddata['customer_latitude'],
                customer_latitude: fetcheddata['customer_longitude'],
                total_price: fetcheddata['total_price'],
                userid: fetcheddata['userid'].toString(),
                order_id: element.id,
                order_status: fetcheddata['order_status'],
                products:  myproducts
                    .map(
                      (e) => Product(
                      price: e['price'],
                      quantity: e['quantity'],
                      title: e['title'].toString(),
                      subtitle: e['subtitle'].toString(),
                      imageurl: e['imageurl'].toString()

                  ),
                )
                    .toList(),
              ),

              );

            }
          }
        }
      });
    });

    return myorders;
  }

  Future<List<Order>> fetch_completed_orders() async {
    List<Order> myorders = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];

        if (fetcheddata['order_status'] != null) {
          if (fetcheddata['order_status'] == "completed") {
            if (user_id == fetcheddata['userid']) {
              myorders.add(Order(
                location: fetcheddata['location'],
                customer_name: fetcheddata['customer_name'],
                notes: fetcheddata['notes'],
                date: fetcheddata['date'],
                customer_longitude: fetcheddata['customer_latitude'],
                customer_latitude: fetcheddata['customer_longitude'],
                total_price: fetcheddata['total_price'],
                userid: fetcheddata['userid'].toString(),
                order_id: element.id,
                order_status: fetcheddata['order_status'],
                products:  myproducts
                    .map(
                      (e) => Product(
                      price: e['price'],
                      quantity: e['quantity'],
                      title: e['title'].toString(),
                      subtitle: e['subtitle'].toString(),
                      imageurl: e['imageurl'].toString()

                  ),
                )
                    .toList(),
              ),

              );

            }
          }
        }
      });
    });

    return myorders;
  }
  Future<List<Order>> fetch_cancelled_orders() async {
    List<Order> myorders = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];


        if (fetcheddata['order_status'] != null) {
          if (fetcheddata['order_status'] == "cancelled") {
            if (user_id == fetcheddata['userid']) {
              myorders.add(Order(
                location: fetcheddata['location'],
                customer_name: fetcheddata['customer_name'],
                notes: fetcheddata['notes'],
                date: fetcheddata['date'],
                customer_longitude: fetcheddata['customer_latitude'],
                customer_latitude: fetcheddata['customer_longitude'],
                total_price: fetcheddata['total_price'],
                userid: fetcheddata['userid'].toString(),
                order_id: element.id,
                order_status: fetcheddata['order_status'],
                products:  myproducts
                    .map(
                      (e) => Product(
                      price: e['price'],
                      quantity: e['quantity'],
                      title: e['title'].toString(),
                      subtitle: e['subtitle'].toString(),
                      imageurl: e['imageurl'].toString()

                  ),
                )
                    .toList(),
              ),

              );

            }
          }
        }

      });
    });

    return myorders;
  }

  Future<void> updateOrderStatus({String ? doc,String ? status}) async {

    Map<String, dynamic> data = {
      'order_status': status,

    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.doc(doc).update(data);
  }
  Future<void> updateOngoingOrder({String ? doc,String ? status,String ? worker_cnic,String ? worker_name}) async {

    Map<String, dynamic> data = {
      'order_status': status,
      'worker_cnic':worker_cnic.toString(),
      'worker_name':worker_name

    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.doc(doc).update(data);
  }

  Future<Map<String,dynamic>?> AssignDeliveryBoy() async {
    Map<String,dynamic>? data;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Workers');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

            if(fetcheddata['active_status']){
       data={
         'cnic':fetcheddata['cnic'],
         'worker_name':fetcheddata['Name']
       };

            }
      });
    });

  return data;
}
}