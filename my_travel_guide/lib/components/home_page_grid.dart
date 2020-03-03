import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/locales/locales.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:my_travel_guide/layouts/timeline.dart';

main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => HomePageGrid(),
      '/camera': (BuildContext context) => main(),
    },
  ));
}

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
  Data data = new Data(
      text: "Landmark",
      address: " ",
      number: " ",
      website: " ",
      rating: " ",
      openingHours: " ");

  RowsAndColumns(BuildContext context) {
    this.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: IntrinsicHeight(
        child: Column(children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCard(
                  AppLocalizations.of(context).landmark,
                  'assets/images/options.png',
                  MaterialPageRoute(
                      builder: (context) => LandmarkPage(data: data,  landmarkImageURL: '',)),
                  160.0, 160.0, 110.0, 110.0),
              _buildCard(
                  AppLocalizations.of(context).cities,
                  'assets/images/near_by_landmarks.png',
                  MaterialPageRoute(
                      builder: (context) => CityPage()),
                  160.0, 160.0, 110.0, 110.0),
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildCard(
                AppLocalizations.of(context).timeline,
                'assets/images/timeline.png',
                MaterialPageRoute(builder: (context) => TimelinePage()), 320.0, 140.0, 100.0, 300.0)
          ]),


        ]),
      ),
    );
  }

  Widget _buildCard(String name, String imageURL,
      MaterialPageRoute materialPageRoute, double width, double height, double imageHeight, double imageWidth) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: InkWell(
            onTap: () {
              Navigator.push(this.context, materialPageRoute);
            },
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: imageHeight,
                    width: imageWidth,
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
                      fontSize: 17.0),
                ),
              ],
            )),
      ),
    );
  }
}
