import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/landmark_information.dart';
import 'package:my_travel_guide/google_apis/google_places_api.dart';
import 'package:my_travel_guide/components/image_slideshow.dart';
import 'package:my_travel_guide/components/app_bar.dart';

class LandmarkPage extends StatelessWidget {
  BuildContext context;
  final Data data;

  LandmarkPage({this.data});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(40.0), child: Appbar(title: data.text,)),
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
            _buildOption(
                "assets/images/search.png",
                MaterialPageRoute(
                    builder: (context) => placePickerIntent(context))),
            _buildOption(
                "assets/images/information.png",
                MaterialPageRoute(
                    builder: (context) => placePickerIntent(context))),
            _buildOption(
                "assets/images/map.png",
                MaterialPageRoute(
                    builder: (context) => placePickerIntent(context))),
            _buildOption(
                "assets/images/add_location.png",
                MaterialPageRoute(
                    builder: (context) => placePickerIntent(context)))
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
                _buildRow("Opening Hours:", data.openingHours),
                _buildRow("Address:", data.address),
                _buildRow("Rating:", data.rating),
                _buildRow("Number:", data.number),
                _buildRow("Website:", data.website),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String rowName, String rowValue) {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 20),
        child: Row(
          children: <Widget>[
            Text(
              rowName,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 5,
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
          Navigator.push(this.context, materialPageRoute);
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
