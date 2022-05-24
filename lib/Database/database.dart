import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:discoveryourplate/Restuarent_Side/modals/restuarent_data.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/order.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart' as auth;
import 'package:discoveryourplate/hybrid_screens/module/location.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
      'restuarent_id':myorder.restuarent_id.toString()
    };


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.add(data);

  }



  CollectionReference ? imgRef;
  firebase_storage.Reference ? ref;

  Future<User_Data?> fetchprofiledata() async {
    User_Data? user;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;

        if (fetcheddata['userid'] == user_id) {

          user = User_Data(
              email: fetcheddata['email'].toString(),
              name: fetcheddata['username'].toString(),
              doc_id: element.id,
              admin: fetcheddata['admin'],
              imageurl: fetcheddata['imageurl'].toString(),
              phone: fetcheddata['phone_no'].toString(),
              uid: user_id,
              BMI: fetcheddata['BMI'],
            height: fetcheddata['height'],
            weight: fetcheddata['weight']
          );

        }
      });
    }).then((value) {});

    return user;
  }

  Future<List<Restuarent_data>?> fetchRestuarents() async {

print("Hello");
    List<Restuarent_data>? restuarents=[];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Restuarents');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;

      restuarents.add(  Restuarent_data(
        status: fetcheddata['status'],
        id: element.id,
        location: fetcheddata['location'].toString(),
        name:
        fetcheddata['Restuarent_name'].toString(),
        userid: fetcheddata['userid'].toString(),
        image_url:
        fetcheddata['image_url'].toString(),
        latitude: fetcheddata['latitude'],
        longitude: fetcheddata['longitude'],
      )
      );
      });
    }).then((value) {});
print("restuarent length is "+restuarents.toString());
    return restuarents;
  }



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



  Future<void> updateBMI({double ? bmi,String ? userdoc,double ? height,double ? weight}) async {

    Map<String, dynamic> data = {
      'BMI': bmi,
      'height':height,
      'weight':weight
    };


  CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(userdoc).update(data);
  }







  Future<void> updateRestuarentStatus({bool ? status}) async {

    Map<String, dynamic> data = {
      'status': status,
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Restuarents');
    collection.doc(restuarent_id).update(data);
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

  Future<void> updateProductStatus({bool ? status,String?  docid}) async {

    Map<String, dynamic> data = {
      'status': status,
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');
    collection.doc(docid).update(data);
  }

  Future<void> updateProductSale({String?  docid,int ? count}) async {

    Map<String, dynamic> data = {
      'sales': count!+1,
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');
    collection.doc(docid).update(data);
  }

  Future deleteProduct(String doc_id)async{
    CollectionReference collection=FirebaseFirestore.instance.collection('Products');
    collection.doc(doc_id).delete();
  }

  Future<void> addMessage(
      {String? chatRoomId, Map<String, dynamic>? chatMessageData}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData!)
        .catchError((e) {
      print(e.toString());
    });
  }



  Future<void> addChatRoom(
      {Map<String, dynamic>? chatRoom, String? chatRoomId}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom!)
        .catchError((e) {
      print(e);
    });
  }



  getChats(String chatRoomId) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    return _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addGroupMessage(
      {String? chatRoomId, Map<String, dynamic>? chatMessageData}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("groupChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData!)
        .catchError((e) {
      print(e.toString());
    });
  }



  Future<String> getUserChats(String user1,String user2) async {
    String chat_id ='';
    CollectionReference collection =
    FirebaseFirestore.instance.collection('chatRoom');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        List users = fetcheddata['users'];
        if (users.contains(user1) && users.contains(user2)) {
          addChatRoom(chatRoomId: element.id, chatRoom: {'users': users});
          chat_id=element.id;
        }
      });
    }).then((value) {

      if(chat_id.isEmpty){
        List users = [
          user1 ,
          user2
        ];

        chat_id = user1+
            "and" +
            user2;

        addChatRoom(chatRoomId: chat_id, chatRoom: {'users': users});

      }
    });

    return chat_id;
  }

  Future getUserInfogetChats(String user2) async {
    final result =await getUserChats(user_id,user2);
    return result;
  }

}
