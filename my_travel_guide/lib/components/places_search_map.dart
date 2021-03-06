import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/result.dart';
import 'package:my_travel_guide/models/error.dart';
import 'package:my_travel_guide/models/place_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';


String baseImageUrl =
    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=';
String apiKeyBase = '&key=';

class PlacesSearchMap extends StatefulWidget {
  final String keyword;
  final double lat;
  final double lng;

  PlacesSearchMap({this.keyword, this.lat, this.lng});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceSearchMap();
  }
}

class _PlaceSearchMap extends State<PlacesSearchMap> {
  static double latitude;
  static double longitude;
  CameraPosition _myLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDotEnv();
    setLatLng();
  }

  void loadDotEnv() async {
    await DotEnv().load(".env");
  }

  void setLatLng() {
    longitude = widget.lng;
    latitude = widget.lat;
    _myLocation = new CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 12,
        bearing: 15.0,
        tilt: 75.0);
  }

  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  List<Marker> markers = <Marker>[];
  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        initialCameraPosition: _myLocation,
        markers: Set<Marker>.of(markers),
        myLocationButtonEnabled: true,
        onTap: _mapTapped,
        onMapCreated: (GoogleMapController controller) {
          _setStyle(controller);
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Container( margin: EdgeInsets.only(bottom: 40), child: FloatingActionButton.extended(
        onPressed: () {
          searchNearby(latitude, longitude, context);
        },
        label: Text('Places Nearby'),
        icon: Icon(Icons.place),
      )),
    );
  }

  void _mapTapped(LatLng location) {
    print(location);
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby(double latitude, double longitude, BuildContext context) async {
    await DotEnv().load('.env');
    String _API_KEY = DotEnv().env['GOOGLE_API_KEY'];
    setState(() {
      markers.clear();
    });
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=15000&keyword=${widget.keyword}';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data, context);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data, BuildContext context) {
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                title: places[i].name,
              ),
              onTap: () {
                showAlertDialog(
                    context,
                    places[i].name,
                    places[i].rating.toString() +
                        '\n' +
                        places[i].vicinity.toString(),
                    places[i].photos.elementAt(0).photoReference);
              },
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }

  showAlertDialog(
      BuildContext context, String placeName, String details, String photoRef) {
    showDialog(
        context: context,
        builder: (BuildContext context) => NetworkGiffyDialog(
              image: Image.network(
                imageURL + photoRef + apiKeyBase + DotEnv().env['GOOGLE_API_KEY'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(
                placeName,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Pompiere',
                ),
              ),
              description: Text(
                details,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              onlyOkButton: true,
              buttonOkColor: Colors.blueAccent,
              buttonOkText: Text(
                "Visit",
                style: TextStyle(color: Colors.white),
              ),
            ));
  }
}
