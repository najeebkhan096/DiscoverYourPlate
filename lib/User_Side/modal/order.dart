


import 'package:discoveryourplate/Restuarent_Side/modals/product.dart';
import 'package:geolocator/geolocator.dart';


class Order{
   List<Product> ? products;
  double ? total_price;
  String ? notes;
  String ? date;
  String ? userid;
  String ? order_id;
  String ? customer_name;
  String ? location;
  String ? order_status;
  double ? customer_latitude;
  double ? customer_longitude;
  String ? worker_cnic;
  String ? worker_name;
  Position ? worker_position;
String ? restuarent_id;

  Order({
    this.restuarent_id,
    this.worker_position,
    this.worker_name,
    this.worker_cnic,
     this.products,
    this.userid,
    this.location,
   this.customer_name,
    this.customer_longitude,
    this.total_price,
    this.notes,
    this.order_status,
    this.date,
    this.order_id,
    this.customer_latitude,

});
}