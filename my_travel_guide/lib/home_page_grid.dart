import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/city.dart';
import 'package:my_travel_guide/home_page.dart';
import 'package:my_travel_guide/landmark.dart';
import 'package:my_travel_guide/main.dart';

class HomePageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Grid(),
    );
  }
}

class Grid extends StatefulWidget {
  @override
  _BuildGrid createState() => new _BuildGrid();
}

class _BuildGrid extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[RowsAndColumns(context)],
      ),
    );
  }
}

class RowsAndColumns extends StatelessWidget {
  BuildContext context;

  RowsAndColumns(BuildContext context) {
    this.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Column(children: [
              _buildCard('Landmark', 'assets/images/options.png', Landmark()),
              _buildCard('Timeline', 'assets/images/timeline_cropped.png', Landmark())
            ]),
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              _buildCard('Cities', 'assets/images/near_by_landmarks.png', City()),
              _buildCard('Camera', 'assets/images/camera.png', City())
            ],
          )),
        ]),
      ),
    );
  }

  Widget _buildCard(String name, String imageURL,StatefulWidget statefulWidget) {
    return Container(
      height: 160.0,
      width: 160.0,
      padding: EdgeInsets.only(top: 10),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  this.context, MaterialPageRoute(builder: (context) => statefulWidget));
            },
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: 110.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(imageURL),
                    )),
                  )
                ]),
                Text(
                  name,
                  style: TextStyle(
                      fontFamily: 'Pompiere',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ],
            )),
      ),
    );
  }
}
