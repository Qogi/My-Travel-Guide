import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/components/image_slideshow.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:my_travel_guide/components/app_bar.dart';

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Appbar(title: "City",)),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          ImageSlideshow(isVisible: false,),
          _buildRow(context),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    final data = Data(text: "Lorem ipsum");
    return Container(
      width: 160,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCard(
              "Map",
              MaterialPageRoute(
                  builder: (context) => LandmarkPage(
                        data: data,
                      ))),
          _buildCard(
              "Landmarks",
              MaterialPageRoute(
                  builder: (context) => LandmarkPage(
                        data: data,
                      )))
        ],
      ),
    );
  }

  Widget _buildCard(String name, MaterialPageRoute materialPageRoute) {
    return Container(
      width: 160.0,
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 7.0,
        child: InkWell(
            onTap: () {
              Navigator.push(this.context, materialPageRoute);
            },
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
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
