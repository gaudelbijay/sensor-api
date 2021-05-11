import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  print("yes");
  // final response = await http.get(Uri.http('127.0.0.1', 'data'));
  final response = await http.get('http://127.0.0.1:5000/data');
  print(response);
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load album!");
  }
}

class Album {
  final int temperature;
  final int humidity;
  final int ph;
  Album({
    @required this.temperature,
    @required this.humidity,
    @required this.ph,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        temperature: json["temperature"],
        humidity: json["humidity"],
        ph: json["ph"]);
  }
}

class SensorData extends StatefulWidget {
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.temperature.toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
