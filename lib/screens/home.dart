import 'package:andhadhunapp/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';

import 'LocAuth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getUserLocation() async {
    var userLocation = await UserLocation().determinePosition();
    print(userLocation);
  }

  FlutterTts flutterTts = FlutterTts();
  Future<Position> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    print(lat);
    // TODO: Use http package to send api call to server
    return position;
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    // return (_getCurrentPosition() == _getCurrentPosition())
    //     ? Scaffold(
    //         body: LocAuth(),
    //       )
    //     : Scaffold(
    //         body: Text('Location not found'),
    //       );
    return (_getCurrentPosition() != _getCurrentPosition())
        ? LocAuth()
        : Scaffold(
            appBar: AppBar(
              title: Text('Andadhun'),
            ),
            body: Container(
              child: Text('This is the body'),
            ),
          );
  }
}

// FlutterTts flutterTts = FlutterTts();
// Future<Position> _getCurrentPosition() async{
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   return position;
// }
