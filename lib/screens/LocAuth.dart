import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class LocAuth extends StatefulWidget {
  const LocAuth({Key? key}) : super(key: key);

  @override
  State<LocAuth> createState() => _LocAuthState();
}

class _LocAuthState extends State<LocAuth> {
  bool _isListening = false;
  bool _speechEnabled = false;
  String _text = '';
  FlutterTts flutterTts = FlutterTts();

  stt.SpeechToText _speech = stt.SpeechToText();

  // String _text = 'Press the button and start speaking';
  // SpeechToText _speechToText = SpeechToText();
  // String _lastWords = '';

  Future _speak() async {
    await flutterTts.speak(
        "स्वागत। बीप के बाद राशि का उल्लेख करें");
  }

  // bool available = await speech.initialize();
  // if (available) {
  //   print('sup');
  //   speech.listen(onResult: (h) {
  //     print(h);
  //   });

  /// This has to happen only once per app
  void _initSpeech() async {
    await flutterTts.setLanguage("hi-IN");
    _speechEnabled = await _speech.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _speak();
    _initSpeech();
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
          print(_text);
        });
      },
    );
    // print("hello");
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _startListening();
          // if (!_isListening) {
          //   _startListening();
          // }
        },
        child: Scaffold(
            backgroundColor: Colors.grey.shade800,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade900,
              centerTitle: true,
              title: Text('AndhaDhun'),
            ),
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "TO",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Andhadhun",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(50),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        style: TextStyle(color: Colors.white54),
                        // If listening is active show the recognized words
                        _text != ''
                            ? '$_text'
                            // If listening isn't active but could be tell the user
                            // how to start it, otherwise indicate that speech
                            // recognition is not yet ready or not supported on
                            // the target device
                            : _speechEnabled
                                ? 'Tap anywhere on the screen to start recording...'
                                : 'Speech not available',
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
