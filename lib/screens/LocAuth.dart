import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LocAuth extends StatefulWidget {
  const LocAuth({Key? key}) : super(key: key);

  @override
  State<LocAuth> createState() => _LocAuthState();
}

class _LocAuthState extends State<LocAuth> {
  bool _isListening = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechEnabled = false;
  String _text = '';
  String userAnswer = '';
  int speechNum = 0;
  FlutterTts flutterTts = FlutterTts();
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];

  // String _text = 'Press the button and start speaking';
  // SpeechToText _speechToText = SpeechToText();
  // String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSetting();
    initMobileNumberState();
    _welcomeSpeak();
  }

  // This has to happen only once per app
  void _initSetting() async {
    await flutterTts.setLanguage("hi-IN");
    _speechEnabled = await _speech.initialize();
    setState(() {});
  }

  Future _welcomeSpeak() async {
    await flutterTts.speak(
        // "अंधाधुन ऐप में आपका स्वागत है। स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|");
        " अंधाधुन ऐप में आपका स्वागत है। स्क्रीन पर कहीं भी क्लिक करें और कृपया अपना नाम बताएंं|");
  }

  Future<void> initMobileNumberState() async {
    // if (!await MobileNumber.hasPhonePermission) {
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      // if (isPermissionGranted) {

      // } else {
      //   print("No permission.");
      // }
      setState(() async {
        try {
          _mobileNumber = (await MobileNumber.mobileNumber)!;
          _simCard = (await MobileNumber.getSimCards)!;
          print(_mobileNumber);
        } on PlatformException catch (e) {
          debugPrint("Failed to get mobile number because of '${e.message}'");
        }
      });
    });
    await MobileNumber.requestPhonePermission;
    // return;
    // }
    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
              'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ))
        .toList();
    return Column(children: widgets);
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
          userAnswer = _text;
          // print(_text);
        });
      },
    );

    // print("hello");
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = true;
      print(userAnswer);
    });
  }

  void _speechListen0() async {
    _startListening();
    Timer(Duration(seconds: 5), () {
      setState(() async {
        _stopListening();

        if (userAnswer == '') {
          flutterTts
              .speak('स्क्रीन पर टैप करने के बाद कृपया अपना नाम दोहराएं |');
        } else {
          speechNum = 1;
          await flutterTts.speak(
              'नमस्ते $userAnswer, स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|');
        }
        // await flutterTts.speak(
        //     "स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|");
        // Timer(Duration(seconds: 4), () {
        //   setState(() {
        //     _startListening();
        //   });
        // });

        //   Timer(Duration(seconds: 5), () {
        //     setState(() {
        //       _stopListening();
        //       if (userAnswer == ''){
        //         flutterTts.speak(
        //             "स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|");
        //       }
        //     });
        //         }
        //

        userAnswer = '';
      });
    });
  }

  void _speechListen1() async {
    _startListening();
    Timer(Duration(seconds: 5), () {
      setState(() async {
        _stopListening();

        if (userAnswer == '') {
          await flutterTts.speak(
              'स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|');
        } else {
          speechNum = 2;
          await flutterTts.speak(
              'आप $userAnswer रुपये निकाल रहे होंगे| यदि सहमत हों तब स्क्रीन पर टैप करने के बाद 1 बोलें');
        }
        userAnswer = '';
      });
    });
  }

  void _speechListen2() async {
    _startListening();
    Timer(Duration(seconds: 7), () {
      setState(() async {
        _stopListening();
        print(userAnswer);
        // if (userAnswer == '') {
        // speechNum = 1;
        // await flutterTts.speak(
        //     'स्क्रीन पर कहीं भी क्लिक करें और बीप के बाद राशि का उल्लेख करें|');
        // }
        // if (userAnswer == '1' ||
        //     userAnswer.toLowerCase() == 'one' ||
        //     userAnswer.toLowerCase() == 'ek') {
        // speechNum = 3;
        await flutterTts.speak(
            'आपका पैसा जल्द ही निकल जाएगा | अंधाधुन ऐप का उपयोग करने के लिए धन्यवाद।');
        // }
        // else {
        // speechNum = 3;

        // flutterTts.speak(
        //     'आपका पैसा जल्द ही निकल जाएगा | अंधाधुन ऐप का उपयोग करने के लिए धन्यवाद।');
        // }
        userAnswer = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // _isListening ? _startListening : _stopListening;

        switch (speechNum) {
          case 0:
            {
              // statements;
              _speechListen0();
            }
            break;

          case 1:
            {
              _speechListen1();
            }
            break;

          case 2:
            {
              _speechListen2();
            }
            break;

          default:
            {
              //statements;
            }
            break;
        }
        // _stopListening();
        // if (!_isListening) {
        //   _startListening();
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title: const Text('AndhaDhun'),
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
              const SizedBox(
                height: 5,
              ),
              const Text(
                "TO",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
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
                  margin: const EdgeInsets.all(50),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    style: const TextStyle(color: Colors.white54),
                    // If listening is active show the recognized words
                    _text != ''
                        ? _text
                        : _speechEnabled
                            ? 'Tap anywhere on the screen to start recording...'
                            : 'Speech not available',
                  ),
                ),
              ),
              fillCards(),
            ],
          ),
        ),
      ),
    );
  }
}
