import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Product{
  final String ? id;
  final String ? title;
  final String ? subtitle;
  final double ? price;
  double ? total;
   int ? quantity;
  final String ?product_doc_id ;
  final String ? category;
  final bool ? status;
  final restuarent_id;
  final String ? imageurl;
  final int ? sales;
  final String ? Restuarent_name;
  final String ? calories;

  Product({@required this.id,@required this.price,@required this.title,@required this.quantity,this.subtitle,this.category,this.product_doc_id,this.status,this.restuarent_id,this.imageurl,this.total,this.sales,this.Restuarent_name,this.calories});

}
String ? restuarent_id;
String ? Restuarent_name;

List<Product> cart_list=[];
