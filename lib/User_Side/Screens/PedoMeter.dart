import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:discoveryourplate/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:discoveryourplate/Database/database.dart';


String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}


class StepsPedoMeter extends StatefulWidget {
  static const routename="StepsPedoMeter";
  @override
  _StepsPedoMeterState createState() => _StepsPedoMeterState();
}

class _StepsPedoMeterState extends State<StepsPedoMeter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Database _database = Database();


  Future onStepCount(StepCount event) async{
    print(event);
    setState(() {
      steps = event.steps.toString();

    });

    await  _database.updateSteps(userdoc: currentuser!.doc_id,step:steps);
    currentuser!.todaysteps=steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print("new step"+event.toString());
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 'Step Count not available';
    });


  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Step Count',style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              steps!.toString(),
              style: TextStyle(fontSize: 60),
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                  ? Icons.accessibility_new
                  : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}