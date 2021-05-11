import 'package:flutter/material.dart';

import 'falsk_api/read_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydroponics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SensorData(),
    );
  }
}
