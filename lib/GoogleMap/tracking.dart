import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;


class Tracking_Screen extends StatefulWidget {
  final String user_id;
  LatLng ini;
  LatLng final_pos;
  Tracking_Screen({required this.user_id,required this.ini,required this.final_pos});
  @override
  _Tracking_ScreenState createState() => _Tracking_ScreenState();
}

class _Tracking_ScreenState extends State<Tracking_Screen> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;


  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {

    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['customer_latitude'],
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['customer_longitude'],
        ),
        zoom: 14.47)));
  }

  //lahore
  Marker ?  _origin;
  Marker  ?  _destination ;

  double distance=0;

  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;

  double cal_distance=0;
  Future _getTheDistance() async {

    double storelat = widget.ini.latitude;
    double storelng = widget.ini.longitude;

    distanceImMeter = await Geolocator.distanceBetween(
        storelat,
        storelng,
        widget.final_pos.latitude,
        widget.final_pos.longitude
    );


    var distance = distanceImMeter?.round().toInt();
    print("distance in meter is "+distanceImMeter.toString());

    cal_distance= (distance! / 1000);
    print("so the distance in km "+cal_distance.toString());
  }

  final CameraPosition klate=CameraPosition(
      target: LatLng(33.68442, 73.047885),
      zoom: 14.47);

  //lahore
  final CameraPosition kgoogle=CameraPosition(
      target: LatLng(31.52037, 74.358747),
      zoom: 14.34
  );


  Polyline mark_polyine(LatLng ini_pos,LatLng final_pos){

    final   kpolyline=Polyline(
      polylineId: PolylineId('kpolyline'),
      points: [
        widget.ini,
        widget.final_pos
      ],
      width: 3,
      color: Colors.red,
    );
    return kpolyline;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Stream<QuerySnapshot<Object?>> fetch_distance_data() {

    return  FirebaseFirestore.instance.collection('Orders').snapshots();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: StreamBuilder(
            stream:  fetch_distance_data(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if(snapshot.hasData){
                if (_added) {

                  mymap(snapshot).then((value) {
                    // Calculate_distance();
                    _getTheDistance();
                  });
                }
              }


              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return
                Container(
                  height: MediaQuery.of(context).size.height*1,
                  child:   Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                            markerId: const MarkerId('origin'),
                            infoWindow: const InfoWindow(title: 'Origin'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                            position: LatLng(
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['customer_latitude'],
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['customer_longitude'],
                            ),

                          ),

                          Marker(

                            markerId: const MarkerId('destination'),
                            infoWindow: const InfoWindow(title: 'Destination'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                            position: LatLng(
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['worker_latitude'],
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['worker_longitude'],
                            ),

                          ),

                        },

                        polylines: {
                          mark_polyine(widget.ini, widget.final_pos)
                        },
                        initialCameraPosition: kgoogle,
                        onMapCreated: (GoogleMapController controller) async {
                          setState(() {
                            _controller = controller;
                            _added = true;
                          });

                          setState(() {
                            _origin=Marker(
                              markerId: const MarkerId('origin'),
                              infoWindow: const InfoWindow(title: 'Origin'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                              position: LatLng(
                                snapshot.data!.docs.singleWhere(
                                        (element) => element.id == widget.user_id)['customer_latitude'],
                                snapshot.data!.docs.singleWhere(
                                        (element) => element.id == widget.user_id)['customer_longitude'],
                              ),

                            );
                            _destination=   Marker(
                              markerId: const MarkerId('destination'),
                              infoWindow: const InfoWindow(title: 'Destination'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                              position: LatLng(
                                snapshot.data!.docs.singleWhere(
                                        (element) => element.id == widget.user_id)['worker_latitude'],
                                snapshot.data!.docs.singleWhere(
                                        (element) => element.id == widget.user_id)['worker_longitude'],
                              ),

                            );
                          });

                        },
                      ),

                      if (cal_distance!=0)
                        Positioned(
                          bottom: 10,

                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.teal.shade300,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))
                            ),
                            width: MediaQuery.of(context).size.width*1,
                            height: MediaQuery.of(context).size.height*0.12,

                            child: Center(
                              child: Text(
                                cal_distance.toString()+" KM",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );

            },
          )),
    );
  }

}
