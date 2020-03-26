import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Home(),
    );
  }
}
