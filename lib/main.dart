import 'package:andhadhunapp/screens/LocAuth.dart';
import 'package:andhadhunapp/screens/home.dart';
import 'package:andhadhunapp/screens/questions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: 'home',
      routes: {
        'home':(context)=>LocAuth(),
        'questions':(context)=>Questions()
        },
    );
  }
}