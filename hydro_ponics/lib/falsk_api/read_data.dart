import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  // final response = await http.get(Uri.http('192.168.1.79:5000/', 'data'));
  final response = await http.get(Uri.parse('http://192.168.1.79:5000/data'));
  // print("response body ${response.body}");
  if (response.statusCode == 200) {
    print(response.body);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load album!");
  }
}

class Album {
  final num temperature;
  final num humidity;
  final num ph;
  final num water_temp;
  final num fan;
  final num light;
  final num flow_rate;
  Album({
    @required this.temperature,
    @required this.humidity,
    @required this.ph,
    @required this.water_temp,
    @required this.fan,
    @required this.light,
    @required this.flow_rate,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        temperature: json["temperature"],
        humidity: json["humidity"],
        ph: json["ph"],
        water_temp: json["water_temp"],
        fan: json["fan"],
        light: json["light"],
        flow_rate: json["flow"]);
  }
}

Timer timer;
