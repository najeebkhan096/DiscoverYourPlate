import 'package:flutter/material.dart';
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height - 70);
    var controlpoint=Offset(50, size.height);
    var endpoint=Offset(size.width/2, size.height);
    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx,endpoint.dy);
    path.lineTo(size.width,size.height);
    path.lineTo(size.width,0);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}