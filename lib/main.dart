import 'package:eighty7/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:eighty7/screens/locations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        routes: {
          '/': (context) => Home(),
          '/location': (context) => location(),
        }
    );
  }
}
