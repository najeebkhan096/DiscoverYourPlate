
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/Chart/barchart_module.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Users_Bar_Chart extends StatelessWidget {
  final List<BarMmodel> ? mylist;

  Users_Bar_Chart({@required this.mylist});




  static List<charts.Series<BarMmodel, String>> _createSampleData(List<BarMmodel> data) {

    return [
      charts.Series<BarMmodel, String>(
        data: data,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (BarMmodel barModeel, _) => barModeel.year,
        measureFn: (BarMmodel barModeel, _) => barModeel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,

          child: charts.BarChart(
            _createSampleData(mylist!),
            animate: true,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.01,
        ),
        Chip(
          backgroundColor: Color(0xff53fdd7),
          label: Text(
            "User Statistic",
            style: TextStyle(color: Colors.black),
          ),
        ),

      ],
    );
  }
}
