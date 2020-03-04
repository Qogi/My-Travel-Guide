import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travel_guide/apis/google_places_api.dart';
import 'package:my_travel_guide/components/home_page_grid.dart';
import 'package:my_travel_guide/layouts/city_map_page.dart';
import 'package:my_travel_guide/layouts/home_page.dart';
import 'package:my_travel_guide/models/place_response.dart';
import 'package:my_travel_guide/models/result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String cityName = "City", cityImageUrl = "";
double cityLat = 0.0, cityLng = 0.0;

class CityPage extends StatefulWidget {
  String imageRef;
  String name;
  final double lat;
  final double lng;

  CityPage({this.lat, this.lng, this.imageRef, this.name});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CityPageState();
  }
}

class _CityPageState extends State<CityPage> {
  SharedPreferences sharedPreferences;
  final myController = TextEditingController();

  List<Result> landmarks;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const String _API_KEY = 'AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A';
  String imageURL =
      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=';
  String apiKEY = '&key=AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A';
  static double latitude;
  static double longitude;

  Text _buildRatingStars(double rating) {
    String stars = '';
    for (int i = 0; i < rating.round(); i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    setLatLng();
    loadLandmarks(cityLat, cityLng, context);
  }

  void setLatLng() {
    longitude = widget.lng;
    latitude = widget.lat;
  }

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _saveValues();
  }

  void _saveValues() {
    if (widget.name != "City") {
      sharedPreferences.setString("cityName", widget.name);
      cityName = widget.name;
      sharedPreferences.setString("cityImageUrl", widget.imageRef);
      cityImageUrl = widget.imageRef;
      sharedPreferences.setDouble("cityLat", widget.lat);
      cityLat = widget.lat;
      sharedPreferences.setDouble("cityLng", widget.lng);
      cityLng = widget.lng;
      _buildCityCard(cityName, cityImageUrl, cityLat, cityLng);
      loadLandmarks(cityLat, cityLng, context);
      _buildListOfLandmark(landmarks);
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildCityCard(cityName, cityImageUrl, cityLat, cityLng),
          _buildListOfLandmark(landmarks)
        ],
      ),
    );
  }

  Widget _buildCityCard(String name, String cityImageUrl, double latitude, double longitude) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0)
              ]),
          child: Hero(
            tag: "assets/images/petra.jpg",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                cityImageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              ),
              Container(
                width: 100,
                child: TextField(
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  cursorColor: Colors.white,
                  onSubmitted: (String cityName) {
//                          searchCity(context,cityName );
                    searchCity(context, cityName);
                  },
                  decoration: InputDecoration.collapsed(
                      hintText: "Search...",
                      hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 15.0,
                    color: Colors.white70,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    cityName,
                    style: TextStyle(color: Colors.white70, fontSize: 20.0),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 20.0,
          bottom: 20.0,
          child: IconButton(
            icon: Icon(Icons.map),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CityMapPage(
                            lat: latitude,
                            lng: longitude,
                            keyword: "Restaurant",
                          )))
            },
          ),
        )
      ],
    );
  }

  Widget _buildListOfLandmark(List<Result> landmarks) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: getLandmarkListSize(landmarks),
        itemBuilder: (BuildContext context, int index) {
          Result result = landmarks.elementAt(index);
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                height: 170.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 120.0,
                            child: Text(
                              result.name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        result.vicinity,
                        style: TextStyle(color: Colors.grey),
                      ),
                      _buildRatingStars(result.rating ?? 0.00),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20.0,
                top: 15.0,
                bottom: 15.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    width: 110.0,
                    fit: BoxFit.cover,
                    image: NetworkImage(imageURL+result.photos.elementAt(0).photoReference+apiKEY),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Result getLandmark(int index) {
    if (landmarks.isEmpty) {
      return new Result(name: " ", vicinity: " ");
    } else {
      return landmarks.elementAt(index);
    }
  }

  int getLandmarkListSize(List<Result> list) {
    if (list == null) {
      return 0;
    } else {
      return 10;
    }
  }

  void loadLandmarks(
      double latitude, double longitude, BuildContext context) async {
    print(latitude);
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=15000&keyword=point+of+interest';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleData(data);
    }
  }

  void _handleData(data) {
    if (data['status'] == "REQUEST_DENIED") {
      print('error');
    } else if (data['status'] == "OK") {
      setState(() {
        landmarks = PlaceResponse.parseResults(data['results']);
        print(landmarks.elementAt(0).name);
      });
    }
  }
}
