import 'package:andhadhunapp/screens/LocAuth.dart';
import 'package:andhadhunapp/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getCurrentPosition() async {
    var userLocation = await UserLocation().determinePosition();
    print(userLocation);
  }

  FlutterTts flutterTts = FlutterTts();
  // Future<Position> _getCurrentPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   var lat = position.latitude;
  //   var long = position.longitude;
  //   print(lat);
  //   // TODO: Use http package to send api call to server
  //   return position;
  // }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
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
    return LocAuth();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Andhadhun'),
    //     centerTitle: true,
    //   ),
    //   body: ElevatedButton(
    //       onPressed: () {
    //         Navigator.pushNamed(context, "main_screen");
    //       },
    //       child: Text('hello')),
    // );
  }
}

// FlutterTts flutterTts = FlutterTts();
// Future<Position> _getCurrentPosition() async{
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   return position;
// }
