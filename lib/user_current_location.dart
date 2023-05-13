import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	9.939093,76.270523),
    zoom: 14.4746,
  );
  List<Marker>markers=<Marker>[ Marker(
      markerId: MarkerId('1'),
      position: LatLng(	9.939093,76.270523),
      infoWindow: InfoWindow(
          title: 'My Position'
      )
  ),];
  List<Marker>list=[

    // Marker(
    //     markerId: MarkerId('2'),
    //     position: LatLng(	10.026617,76.308411),
    //     infoWindow: InfoWindow(
    //         title: 'Lulu mall'
    //     )
    // )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //markers.addAll(list);
  }

  Future<Position>getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
       print("Error"+error.toString());
    });
   return Geolocator.getCurrentPosition();
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
          getUserCurrentLocation().then((value)async {
           print('my current location is:');
           print(value.longitude.toString()+""+value.latitude.toString());
           markers.add(
               Marker(markerId: MarkerId('2'),
                   position: LatLng(value.latitude,value.longitude),
                 infoWindow: InfoWindow(
                   title: 'My Home'
                 )
               )
           );
           CameraPosition cameraPosition=CameraPosition(
             zoom: 14,
               target: LatLng(value.latitude,value.longitude));
           final GoogleMapController controller=await _controller.future;
           controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          });
          setState(() {

          });

        },
      ),
    );
  }
}
