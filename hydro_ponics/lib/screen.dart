import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_ponics/component/reusable_card.dart';
import 'package:hydro_ponics/constant.dart';

import 'falsk_api/read_data.dart';

String lightstatus;
String fanstatus;

class FrontPage extends StatefulWidget {
  const FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => fetchAlbum());
    futureAlbum = fetchAlbum();
  }

  Future<Album> _refreshLocalGallery() async {
    return fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Hydroponics System"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.temperature.toString());
                          return Text(
                            "TEMPERATURE : ${snapshot.data.temperature.toDouble()}",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "HUMIDITY : ${snapshot.data.humidity.toDouble()}",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "WATER TEMPERATURE : ${snapshot.data.water_temp.toDouble()}",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "PH VALUE : ${snapshot.data.ph.toDouble()}",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.fan.toInt() == 1) {
                            fanstatus = "ON";
                          } else {
                            fanstatus = "OFF";
                          }
                          return Text(
                            "Fan Status : $fanstatus",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.light.toInt() == 1) {
                            lightstatus = "ON";
                          } else {
                            lightstatus = "OFF";
                          }
                          return Text(
                            "Light Status : $lightstatus",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Flow Rate : ${snapshot.data.flow_rate.toDouble()}",
                            style: KLabelTextStyel,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Server is Down");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
