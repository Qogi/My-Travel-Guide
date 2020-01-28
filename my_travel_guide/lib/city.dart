import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/home_page.dart';
import 'package:my_travel_guide/image_slideshow.dart';
import 'package:my_travel_guide/landmark.dart';

main() {
  runApp(City());
}

class City extends StatefulWidget {
  @override
  _LandmarkState createState() => _LandmarkState();
}

class _LandmarkState extends State<City> {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize( preferredSize: Size.fromHeight(40.0), child: AppBar(
        title: Text(
          "City",
          style: TextStyle(color: Colors.black, fontSize: 17.0),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      )),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          ImageSlideshow(),
          _buildRow(context),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(5),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCard("Map", Landmark()),
          _buildCard("Landmarks", Landmark())
        ],
      ),
    );
  }

  Widget _buildCard(String name, StatefulWidget statefulWidget) {
    return Container(
      width: 160.0,
      padding: EdgeInsets.all(10),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 7.0,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  this.context, MaterialPageRoute(builder: (context) => statefulWidget));
            },
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5), child:Text(
                  name,
                  style: TextStyle(
                      fontFamily: 'Pompiere',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )),
              ],
            )),
      ),
    );
  }
}
