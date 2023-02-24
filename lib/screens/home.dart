import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';



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
    print(position);
    return position;
  }

  Widget build(BuildContext context) {
    return (_getCurrentPosition() == _getCurrentPosition())?Scaffold(
      body: Text('Home'),
    ):Scaffold(
      body: Text('Location not found'),
    );
  }
}
