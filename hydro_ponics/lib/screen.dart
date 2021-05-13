import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_ponics/component/reusable_card.dart';
import 'package:hydro_ponics/constant.dart';

import 'falsk_api/read_data.dart';

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
    futureAlbum = fetchAlbum();
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
                child: Center(
                  child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "TEMPERATURE : ${snapshot.data.temperature.toString()}",
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
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "HUMIDITY : ${snapshot.data.humidity.toString()}",
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
          Expanded(
            child: Reusable(
              cardColor: Colors.greenAccent,
              cardChild: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "PH VALUE : ${snapshot.data.ph.toString()}",
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
        ],
      ),
    );
  }
}
