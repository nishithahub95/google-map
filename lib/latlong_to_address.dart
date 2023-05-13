import 'package:flutter/material.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

class LatlongtoAddress extends StatefulWidget {
  const LatlongtoAddress({Key? key}) : super(key: key);

  @override
  State<LatlongtoAddress> createState() => _LatlongtoAddressState();
}

class _LatlongtoAddressState extends State<LatlongtoAddress> {
  String SearchAddress = '', place = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(SearchAddress),
            Text(place),
            GestureDetector(
              onTap: () async {
                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);
                setState(() {
                  SearchAddress = locations.last.latitude.toString() +
                      locations.last.longitude.toString();
                  place = placemarks.reversed.last.country.toString() +
                      "" +
                      placemarks.reversed.last.street.toString() +
                      "" +
                      placemarks.reversed.last.name.toString();
                });
              },
//               onTap: ()async{
//                 final coordinates=new Coordinates(10.026617,  76.308411);
//                 var address=await Geocoder.local.findAddressesFromCoordinates(coordinates);
//                 var first=address.first;
//                 print(first.featureName.toString()+first.addressLine.toString());
//                SearchAddress=first.featureName.toString()+'  '+first.addressLine.toString();
//                setState(() {
//
//                });
//
// // From a query
//                 final query = "1600 Amphiteatre Parkway, Mountain View";
//                 var addresses = await Geocoder.local.findAddressesFromQuery(query);
//                 var next = addresses.first;
//                 print("${ next.featureName} : ${ next.coordinates}");
//               },
              child: Center(
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('Convert'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
