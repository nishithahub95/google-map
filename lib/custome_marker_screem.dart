
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;

class CustomeMarkerScreem extends StatefulWidget {
  const CustomeMarkerScreem({Key? key}) : super(key: key);

  @override
  State<CustomeMarkerScreem> createState() => _CustomeMarkerScreemState();
}

class _CustomeMarkerScreemState extends State<CustomeMarkerScreem> {
  Uint8List? markerImage;
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	9.939093,76.270523),
    zoom: 14.4746,
  );
  List<String> images=['images/car.png','images/dish.png'];
 final List<Marker>markers=[
    // Marker(markerId: MarkerId('5'),
    //  position: LatLng(10.107796, 76.350693)  )
        ];
  final List<LatLng> _latlag=<LatLng>[
    LatLng(10.107796, 76.350693),LatLng(10.023286,76.311371)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lodData();
  }

  Future<Uint8List> getBytesFromAssets(String path,int width)async{
    ByteData data=await rootBundle.load(path);
    ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetWidth: width);
    ui.FrameInfo fi=await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  lodData()async{
    for(int i=0;i<images.length;i++){
      final Uint8List markerIcon=await getBytesFromAssets(images[i], 100);
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
      position: _latlag[i],
       // icon: BitmapDescriptor.defaultMarker,
          icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: 'marker'+i.toString()
        )
      ));
      setState(() {

      });
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
        markers:Set<Marker>.of(markers) ,
    onMapCreated: (GoogleMapController controller ) {
      _controller.complete(controller);
    }


    ),
      ),
    );
  }
}
