import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        children: <Widget>[
          RowsAndColumns()
        ],
      ),
    );
  }

}

class RowsAndColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Column(children: [
              _buildCard('Landmark', 'assets/images/options.png'),
              _buildCard('Timeline', 'assets/images/timeline_cropped.png')
            ]),
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              _buildCard('Cities', 'assets/images/near_by_landmarks.png'),
              _buildCard('Camera', 'assets/images/camera.png')
            ],
          )),
        ]),
      ),
    );
  }

  Widget _buildCard(String name, String imageURL) {
    return Container(
      height: 160.0,
      width: 160.0,
      padding: EdgeInsets.only(top: 10),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: 110.0,
                width: 110.0,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imageURL))),
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
        ),
      ),
    );
  }
}
