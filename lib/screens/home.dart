import 'package:andhadhunapp/services/location.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() async {
    var userLocation = await UserLocation().determinePosition();
    print(userLocation);
  }

  @override
  // FlutterTts flutterTts = FlutterTts();
  // Future<Position> _getCurrentPosition() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }

  Widget build(BuildContext context) {
    // return (_getCurrentPosition() == _getCurrentPosition())
    //     ? Scaffold(
    //         body: LocAuth(),
    //       )
    //     : Scaffold(
    //         body: Text('Location not found'),
    //       );
    return Scaffold(
      appBar: AppBar(
        title: Text('Andadhun'),
      ),
      body: Container(
        child: Text('This is the body'),
      ),
    );
  }
}
