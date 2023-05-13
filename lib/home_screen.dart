
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
      target: LatLng(	9.939093,76.270523),
  zoom: 14.4746,
  );
  List<Marker>markers=[];
  List<Marker>list=[
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(	9.939093,76.270523),
      infoWindow: InfoWindow(
        title: 'My Position'
      )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(	10.026617,76.308411),
        infoWindow: InfoWindow(
            title: 'Lulu mall'
        )
    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.addAll(list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:_cameraPosition ,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        markers:Set<Marker>.of(markers) ,
        onMapCreated: (GoogleMapController controller ){
          _controller.complete(controller);

        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching_rounded),
        onPressed: ()async{
          GoogleMapController controller=await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(19.07283,	72.88261),
                zoom: 14.4746,)

            )
          );
          setState(() {

          });

        },
      ),
    );
  }
}
