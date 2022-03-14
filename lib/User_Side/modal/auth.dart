// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:food_app/food_app_constants.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'food_widgets/http_exception.dart';
//
// class food_side_Authentication with ChangeNotifier
// {
//
//   Future<void> signUp(String email, String password) async
//   {
//     const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyATsjxcJg0Scg4xsiTcAsNHfL9imPPgT7A';
//     try{
//       final response = await http.post(Uri.parse(url), body: json.encode(
//           {
//             'email' : email,
//             'password' : password,
//             'returnSecureToken' : true,
//           }
//       ));
//       final responseData = json.decode(response.body);
//      print("lail;a");
//       print(responseData);
//       if(responseData['error'] != null)
//       {
//
//         throw HttpException(responseData['error']['message']);
//       }
//       food_side_authtoken = responseData['idToken'];
//       food_side_userid = responseData['localId'];
//
//       food_side_expirydate = DateTime.now().add(
//         Duration(
//           seconds: int.parse(responseData['expiresIn']),
//         ),
//       );
//     } catch (error)
//     {
//
//       throw error;
//     }
//
//   }
//
//   Future<void> logIn(String email, String password) async
//   {
//     const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyATsjxcJg0Scg4xsiTcAsNHfL9imPPgT7A';
//
//     try{
//       final response = await http.post(Uri.parse(url), body: json.encode(
//           {
//             'email' : email,
//             'password' : password,
//             'returnSecureToken' : true,
//           }
//       ));
//       final responseData = json.decode(response.body);
//       if(responseData['error'] != null)
//       {
//         throw HttpException(responseData['error']['message']);
//       }
// //      print(responseData);
//
//
//       food_side_authtoken = responseData['idToken'];
//       food_side_userid = responseData['localId'];
//       food_side_expirydate = DateTime.now().add(
//
//         Duration(
//           seconds: int.parse(responseData['expiresIn']),
//         ),
//       );
//
//
//         var dir=await getApplicationDocumentsDirectory();
//         Hive.init(dir.path);
//       food_side_box=await Hive.openBox("log_in_data");
//       food_side_box.put('authtoken',food_side_authtoken );
//       food_side_box.put('userid',food_side_userid);
// print("sania");
//       print(food_side_expirydate);
//       print("museera");
//       food_side_box.put('expirydate',food_side_expirydate);
//
//
//
//     } catch(error)
//     {
//       throw error;
//     }
//
//   }
// }
