

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationWithAddress  extends StatefulWidget {
  const CurrentLocationWithAddress ({Key? key}) : super(key: key);

  @override
  State<CurrentLocationWithAddress > createState() => _CurrentLocationWithAddressState();
}

class _CurrentLocationWithAddressState extends State<CurrentLocationWithAddress > {
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
  Future<Position> getUserCurrentLocation()async{
await Geolocator.requestPermission().then((value) {

}).onError((error, stackTrace){
  print('Error'+error.toString());
});
return await Geolocator.getCurrentPosition();
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
        onPressed: ()async{
         getUserCurrentLocation().then((value) async{
           print(value.latitude.toString()+""+value.longitude.toString());

           markers.add(
             Marker(markerId: MarkerId('3'),
             position: LatLng(value.latitude,value.longitude),
                 infoWindow: InfoWindow(
                 title: 'My Home'
             )
             )
           );
           CameraPosition cameraPosition= CameraPosition(
             zoom: 14,
               target: LatLng(value.latitude,value.longitude));
           final GoogleMapController controller=await _controller.future;
           controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
         });
        },
        child: Icon(Icons.location_searching_rounded),
      ),
    );
  }
}
