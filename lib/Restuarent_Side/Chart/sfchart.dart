import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/Restuarent_Side/Chart/barchart_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class SfChart extends StatefulWidget {
  final List<BarMmodel> ? mylist;

  SfChart({@required this.mylist});

  @override
  _SfChartState createState() => _SfChartState();
}

class _SfChartState extends State<SfChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Container(
            height: 400,
            child: SfCartesianChart(

                primaryXAxis: CategoryAxis(),
                // Chart title

                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,

                series: <LineSeries<BarMmodel, String>>[
                  LineSeries<BarMmodel, String>(
                      dataSource:  widget.mylist!,
                      xValueMapper: (BarMmodel sales, _) => sales.year,
                      yValueMapper: (BarMmodel sales, _) => sales.value,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ]
            )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.01,
        ),
        Chip(
          backgroundColor: Color(0xff53fdd7),
          label: Text(
            "Monthly Revenue",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );

  }
}
