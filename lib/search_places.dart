
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PlaceSearch extends StatefulWidget {
  const PlaceSearch({Key? key}) : super(key: key);

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  TextEditingController _searchController=TextEditingController();
  var uuid=Uuid();
  String _sessionToken='12345';
  List<dynamic> _placesList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      onChange();
    });
  }
 void onChange(){
    if(_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();//Store devise id that makes the requist
      });
    }
    getSugestion(_searchController.text);

  }

  void getSugestion(String input)async{
    String kPLACES_API_KEY='AIzaSyBM3O_6tckRPA2AtFJSB1N_-jQFABzjKqI';
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response=await http.get(Uri.parse(request));
    if(response.statusCode==200){
 _placesList=jsonDecode(response.body.toString())['predictions'];
    }else{
      throw Exception(
        'Failed to load data'
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Places'),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search by places',

            ),
          ),
          Expanded(child: 
          ListView.builder(
              itemCount: _placesList.length,
              itemBuilder: (context,index){
                  return ListTile(
                     onTap: ()async{
                       List<Location> locations =
                           await locationFromAddress(_placesList[index]['description']);
                       print(locations.last.longitude);
                       print(locations.last.latitude);
                     },
                     title:Text(_placesList[index]['description']) ,);

          })
          )

        ],
      ),
    );
  }
}
