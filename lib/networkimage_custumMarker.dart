import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NetworkImageCutomMarker extends StatefulWidget {
  const NetworkImageCutomMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageCutomMarker> createState() => _NetworkImageCutomMarkerState();
}

class _NetworkImageCutomMarkerState extends State<NetworkImageCutomMarker> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	9.939093,76.270523),
    zoom: 14.4746,
  );

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
    loadData();
  }
  loadData()async{
   for(int i=0;i<_latlag.length;i++){
     Uint8List? image=await _loadNetworkImage('https://cdn3.iconfinder.com/data/icons/business-ultimate-set-1/64/d-07-512.png');
     final ui.Codec markerImageCodec = await instantiateImageCodec(
       image!.buffer.asUint8List(),
       //to resize the network image size
       targetHeight: 200,
       targetWidth: 200,
     );
     final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
     final ByteData? byteData = await frameInfo.image.toByteData(
       format: ImageByteFormat.png,
     );

     final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
     markers.add(Marker(
         markerId: MarkerId(i.toString()),
         position: _latlag[i],
         icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
          //icon: BitmapDescriptor.defaultMarker,
         //icon: BitmapDescriptor.fromBytes(markerIcon),
         infoWindow: InfoWindow(
             title: 'marker'+i.toString()
         )
     ));
     setState(() {

     });

   }
  }
  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration(size: Size.fromHeight(10) )).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png ,);
    return byteData?.buffer.asUint8List();
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
