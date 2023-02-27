import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'LocAuth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  FlutterTts flutterTts = FlutterTts();
  Future<Position> _getCurrentPosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    print(lat);
    // TODO: Use http package to send api call to server
    return position;
  }

  Widget build(BuildContext context) {
    return (_getCurrentPosition() != _getCurrentPosition())?LocAuth() :Scaffold(
      body: Text('Location not found'),
    );
  }
}
