import 'package:andhadhunapp/screens/LocAuth.dart';
import 'package:andhadhunapp/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return LocAuth();
  }
}
