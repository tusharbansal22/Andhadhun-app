import 'package:andhadhunapp/screens/LocAuth.dart';
import 'package:andhadhunapp/screens/questions.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';
// import 'screens/trial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => Home(),
        'main_screen': (context) => LocAuth(),
        'questions': (context) => Questions()
      },
    );
  }
}
