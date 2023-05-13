import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {

  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	9.939093,76.270523),
    zoom: 14.4746,
  );
  List<String> images=['images/car.png','images/dish.png'];
  // final List<Marker>markers=[
  //   // Marker(markerId: MarkerId('5'),
  //   //  position: LatLng(10.107796, 76.350693)  )
    final Set<Marker>_marker={};

  final Set<Polyline>_polyline={};
  final List<LatLng> _latlag=<LatLng>[
    LatLng(10.107796, 76.350693),LatLng(10.023286,76.311371)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<_latlag.length;i++){
      _marker.add(
        Marker(markerId: MarkerId(i.toString(),),
        position: _latlag[i],
          infoWindow:const InfoWindow(
            title: 'New place',
            snippet: '5 star rating'
          ),
          icon: BitmapDescriptor.defaultMarker
        )
      );
      setState(() {

      });
      _polyline.add(Polyline(polylineId:PolylineId('1'),
          points: _latlag,
        color: Colors.orangeAccent
      ));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: SafeArea(
             child: GoogleMap(initialCameraPosition:_cameraPosition,
                 mapType: MapType.normal,
                 myLocationEnabled: true,
                 compassEnabled: true,
                 markers:_marker ,
                 polylines: _polyline,
                 onMapCreated: (GoogleMapController controller ) {
                   _controller.complete(controller);
                 }


             ),
           ),
    );
  }
}
