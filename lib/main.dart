import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_project/currentlocation_address.dart';
import 'package:flutter_google_map_project/custome_marker_infowindow.dart';
import 'package:flutter_google_map_project/custome_marker_screem.dart';
import 'package:flutter_google_map_project/home_screen.dart';
import 'package:flutter_google_map_project/latlong_to_address.dart';
import 'package:flutter_google_map_project/networkimage_custumMarker.dart';
import 'package:flutter_google_map_project/polygon_screen.dart';
import 'package:flutter_google_map_project/styleGooglemapScreen.dart';
import 'package:flutter_google_map_project/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: StyleGoogleMapScreen()
    );
  }
}

