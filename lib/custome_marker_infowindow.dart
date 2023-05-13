

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =CustomInfoWindowController();
  final List<Marker>markers=[];
  final List<LatLng> _latlag=<LatLng>[
    LatLng(10.107796, 76.350693),LatLng(10.023286,76.311371)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i=0;i<_latlag.length;i++){
      if(i%2==0){
        markers.add(Marker(
            markerId: MarkerId(i.toString(),),
            icon: BitmapDescriptor.defaultMarker,
            position: _latlag[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                // Text('custom info window'),
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:Center(child: CircleAvatar(radius: 30,backgroundColor: Colors.blue,),)
                  ),
                  _latlag[i]
              );
            }
        ));
      }else{
        markers.add(Marker(
            markerId: MarkerId(i.toString(),),
            icon: BitmapDescriptor.defaultMarker,
            position: _latlag[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                // Text('custom info window'),
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 300,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://images.pexels.com/photos/533325/pexels-photo-533325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                fit: BoxFit.fitWidth,
                                //filterQuality: FilterQuality.high,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10 , right: 10),
                            child: Row(
                                children: const[
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Beef Tacos',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '.3 mi.',
                                    // widget.data!.date!,

                                  )
                                ]
                            )
                        ), const Padding(
                          padding:  EdgeInsets.only(top: 10 , left: 10 , right: 10),
                          child: Text(
                            'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                            maxLines: 2,

                          ),
                        ),

                      ],
                    ),
                  ),
                  _latlag[i]
              );
            }
        ));
      }


      setState(() {

      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(initialCameraPosition: CameraPosition(
            target: LatLng(10.1258,76.3002),
            zoom: 14
          ),
            markers:Set<Marker>.of(markers) ,
              onTap: (position){
            _customInfoWindowController.hideInfoWindow!();//hide info window when tap on google map
              },
              onCameraMove: (position){
            _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller ) {
              _customInfoWindowController.googleMapController=controller;

              }

          ),
          CustomInfoWindow(
                  height: 200,
              width: 300,
              controller: _customInfoWindowController,
          offset: 35,
          )

        ],
      ),
    );
  }
}
