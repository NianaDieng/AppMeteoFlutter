import 'package:flutter/material.dart';
import 'package:meteo2/views/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meteo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: meteo(),
    );
  }
}
