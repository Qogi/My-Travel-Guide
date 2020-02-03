import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/google_places_api.dart';
import 'package:my_travel_guide/layouts/home_page.dart';
import 'package:my_travel_guide/components/image_slideshow.dart';
import 'package:place_picker/place_picker.dart';
import "package:google_maps_webservice/places.dart";

main() {
  runApp(Landmark());
}

class Landmark extends StatefulWidget {
  @override
  _LandmarkState createState() => _LandmarkState();
}

class _LandmarkState extends State<Landmark> {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize( preferredSize: Size.fromHeight(40.0), child: AppBar(
        title: Text(
          "Landmark",
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
          _buildOptionsCard(context),
          _buildCard()
        ],
      ),
    );
  }

  Widget _buildOptionsCard(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(10),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildOption("assets/images/search.png", MaterialPageRoute(builder: (context) => placePickerIntent(context))),
//            _buildOption("assets/images/information.png", HomePage()),
//            _buildOption("assets/images/map.png", HomePage()),
//            _buildOption("assets/images/add_location.png", HomePage())
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      height: 260.0,
      width: 160.0,
      padding: EdgeInsets.all(10),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildRow("Information", ""),
                _buildRow("Opening Hours:", "12:00"),
                _buildRow("Address:", "Ireland, Dublin"),
                _buildRow("Rating:", "4.5"),
                _buildRow("Phone Number:", "01 098 123"),
                _buildRow("Website:", "www.google.com"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String rowName, String rowValue) {
    return Padding(
        padding: EdgeInsets.only(left: 25, top: 20),
        child: Row(
          children: <Widget>[
            Text(
              rowName,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              rowValue,
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }

  Widget _buildOption(String url, MaterialPageRoute materialPageRoute) {
    return InkWell(
        onTap: () {
          Navigator.push(this.context,
              materialPageRoute);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Stack(children: <Widget>[
              Container(
                height: 23.5,
                width: 23.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(url),
                )),
              )
            ])));
  }
}
