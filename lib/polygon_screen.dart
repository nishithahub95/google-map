import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	 10.109514, 76.325952),
    zoom: 14.4746,
  );
  final Set<Marker>_marker={};
  Set<Polygon> _polygon=HashSet<Polygon>();
  List<LatLng> poins=[
    LatLng(10.109514, 76.325952),
    LatLng(10.116522, 76.342946),
    LatLng(10.126044, 76.337384),
    LatLng(10.109514, 76.325952),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
        polygonId: PolygonId('1'),
        points: poins,
      fillColor: Colors.grey.withOpacity(0.2),
      geodesic: true,
      strokeWidth: 2,strokeColor: Colors.red

    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: GoogleMap(
            initialCameraPosition:_cameraPosition,
              mapType: MapType.normal,
           myLocationEnabled: true,
           compassEnabled: true,
           markers:Set<Marker>.of(_marker),
             polygons: _polygon,
             onMapCreated: (GoogleMapController controller ) {
               _controller.complete(controller);
             }


         ),
    );
  }
}
