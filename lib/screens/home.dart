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
  // String mobileNumber = '123';
  // List<SimCard> _simCard = <SimCard>[];

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
    // MobileNumber.listenPhonePermission((isPermissionGranted) {
    //   // if (isPermissionGranted) {
    //   initMobileNumberState();
    //   // } else {
    //   //   print("No permission.");
    //   // }
    // });
  }

  // Future<void> initMobileNumberState() async {
  //   // if (!await MobileNumber.hasPhonePermission) {
  //   await MobileNumber.requestPhonePermission;
  //   // return;
  //   // }
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     mobileNumber = (await MobileNumber.mobileNumber)!;
  //     _simCard = (await MobileNumber.getSimCards)!;
  //     print(mobileNumber);
  //   } on PlatformException catch (e) {
  //     debugPrint("Failed to get mobile number because of '${e.message}'");
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {});
  // }

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
