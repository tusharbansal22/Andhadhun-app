import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LocAuth extends StatefulWidget {
  const LocAuth({Key? key}) : super(key: key);

  @override
  State<LocAuth> createState() => _LocAuthState();
}

class _LocAuthState extends State<LocAuth> {
  FlutterTts flutterTts = FlutterTts();
  Future _speak() async{
     await flutterTts.speak("Welcome to Andhadhun, you are using this app cause you are blind,lmao");
  }
  @override
  void initState() {
    _speak();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:Text('hello'));
  }
}
