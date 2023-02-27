import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LocAuth extends StatefulWidget {
  const LocAuth({Key? key}) : super(key: key);

  @override
  State<LocAuth> createState() => _LocAuthState();
}

class _LocAuthState extends State<LocAuth> {
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  Future _speak() async{
     await flutterTts.speak("Welcome to Andhadhun, you are using this app cause you are blind,lmao");
     bool available = await speech.initialize();
     if(available){
       print('sup');
       speech.listen( onResult: (h){
         print(h);
       });
     }

  }
  @override
  void initState() {
    _speak();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          width:double.infinity,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("WELCOME",style: TextStyle(fontSize: 32),),
              Text("to",style: TextStyle(fontSize: 24),),
              Text("Andhadhun",style: TextStyle(fontSize: 32),),
            ],
          ),
        )
        );
  }
}
