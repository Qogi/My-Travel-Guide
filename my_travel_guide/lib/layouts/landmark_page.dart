import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_travel_guide/firebase/cloud_firestore.dart';
import 'package:my_travel_guide/layouts/city_map_page.dart';
import 'package:my_travel_guide/locales/locales.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/apis/google_places_api.dart';
import 'package:my_travel_guide/components/app_bar.dart';
import 'package:my_travel_guide/layouts/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new LandmarkPage());

String name = "Landmark",
    openingHours = " ",
    address = " ",
    rating = " ",
    number = " ",
    website = " ",
    photoURL = " ",
    id = "";

double lat = 0.0, lng = 0.0;

class LandmarkPage extends StatefulWidget {
  final Data data;
  String landmarkImageURL = '';

  LandmarkPage({this.data, this.landmarkImageURL});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _LandmarkPage();
  }
}

class _LandmarkPage extends State<LandmarkPage> {
  DateTime selectedDate = DateTime.now();
  SharedPreferences prefs;

  initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    _saveValues();
    loadDotEnv();
  }

  void loadDotEnv() async {
    await DotEnv().load('.env');
  }

  void _saveValues() {
    if(widget.data != null){
      if (widget.data.text != "Landmark") {
        setState(() {
          prefs.setString("id", id);
          id = widget.data.id;
          name = widget.data.text;
          prefs.setString("name", name);
          openingHours = widget.data.openingHours;
          prefs.setString("openingHours", openingHours);
          address = _buildAddress();
          prefs.setString("address", address);
          rating = widget.data.rating;
          prefs.setString("rating", rating);
          number = widget.data.number;
          prefs.setString("number", number);
          website = widget.data.website;
          prefs.setString("website", website);
          photoURL = widget.data.photoURL;
          prefs.setDouble("lat", lat);
          lat = widget.data.lat;
          prefs.setDouble("lng", lng);
          lng = widget.data.lng;
          prefs.setString("photoURL", photoURL);
          _buildLandmarkImage(photoURL);
          _buildCard(openingHours, rating, number, _buildAddress(), website);
        });
      }
    }

  }

  String _buildAddress() {
    return widget.data.address
            .substring(0, widget.data.address.length.toInt() ~/ 1.5)
            .toString() +
        "\n" +
        widget.data.address
            .substring(widget.data.address.length.toInt() ~/ 2 + 1,
                widget.data.address.length.toInt())
            .toString();
  }

  Future<bool> pop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Appbar(
            title: name,
          )),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30.0, top: 10.0),
                child: Text(
                  "Choose \nYour \nDestination",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pompiere",
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(top: 200.0, left: 230),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/options.png")
                  )
                ),
              ),
              _buildLandmarkImage(photoURL),
            ],
          ),
          _buildOptionsCard(context),
          _buildCard(openingHours, rating, number, address, website)
        ],
      ),
    );
  }

  Widget _buildLandmarkImage(String url) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Image.network(
          url,
          width: 350,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOptionsCard(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.only(left: 10, right: 10),
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
                    builder: (context) => placePickerIntent(
                        context, DotEnv().env['GOOGLE_API_KEY']))),
            _buildOption(
                "assets/images/map.png",
                MaterialPageRoute(
                    builder: (context) => CityMapPage(
                          lat: lat,
                          lng: lng,
                          keyword: "Museum",
                        ))),
            _buildAddToLandmark()
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String openingHours, String rating, String number,
      String address, String website) {
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
                _buildRow(AppLocalizations.of(context).information, "",
                    TextStyle(color: Colors.black, fontSize: 12.0)),
                _buildRow(
                    AppLocalizations.of(context).openingHours,
                    openingHours,
                    TextStyle(color: Colors.black, fontSize: 12.0)),
                _buildRow(AppLocalizations.of(context).address, address,
                    TextStyle(color: Colors.black, fontSize: 12.0)),
                _buildRow(AppLocalizations.of(context).rating, rating,
                    TextStyle(color: Colors.black, fontSize: 12.0)),
                _buildRow(AppLocalizations.of(context).number, number,
                    TextStyle(color: Colors.black, fontSize: 12.0)),
                _buildRow(
                    AppLocalizations.of(context).website,
                    website,
                    TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 12.0)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String rowName, String rowValue, TextStyle textStyle) {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 20),
        child: Row(
          children: <Widget>[
            Text(
              rowName,
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                if (rowName == "Website") {
                  _launchURL(rowValue);
                }
                ;
              },
              child: Text(
                rowValue,
                style: textStyle,
              ),
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

  _launchURL(String landmarkURL) async {
    if (await canLaunch(landmarkURL)) {
      await launch(landmarkURL);
    } else {
      throw 'Could not launch $landmarkURL';
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)).whenComplete(() => {addLandmarkToTimeline(id, name, selectedDate.toString())});

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget _buildAddToLandmark() {
    return InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Stack(children: <Widget>[
              Container(
                height: 23.5,
                width: 23.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/add_location.png"),
                )),
              )
            ])));
  }
}
