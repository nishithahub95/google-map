

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String mapTheme='';
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _cameraPosition=CameraPosition(
    target: LatLng(	9.939093,76.270523),
    zoom: 14.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((value){
     mapTheme=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map style') ,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((string)  {
                      setState(() {

                      });
                      value.setMapStyle(string);

                    })
                  });
                },
                child: Text('Silver')),
            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/retro_theme.json').then((string) {
                      setState(() {

                      });
                      value.setMapStyle(string);

                    })
                  });
                },
                child: Text('Retro')),
            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/aubergine_theme.json').then((string)  {
                      setState(() {

                      });
                      value.setMapStyle(string);

                    })
                  });
                },
                child: Text('Aubergain'))
          ]),


        ]),


      body: SafeArea(
        child: GoogleMap(initialCameraPosition:_cameraPosition,

            myLocationEnabled: true,
            compassEnabled: true,
            //markers:Set<Marker>.of(markers) ,
            onMapCreated: (GoogleMapController controller ) {
          controller.setMapStyle(mapTheme);
              _controller.complete(controller);
            }


        ),
      ),
    );
  }
}
