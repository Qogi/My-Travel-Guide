import 'dart:async';
import 'dart:convert';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:my_travel_guide/models/result.dart';
import 'package:my_travel_guide/models/error.dart';
import 'package:my_travel_guide/models/place_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesSearchMap extends StatefulWidget {
  final String keyword;
  final double lat;
  final double lng;

  PlacesSearchMap({this.keyword, this.lat, this.lng});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("in map");
    print(lat);
    return _PlaceSearchMap();
  }
}

class _PlaceSearchMap extends State<PlacesSearchMap> {
  static const String _API_KEY = 'AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A';
  static double latitude;
  static double longitude;
  CameraPosition _myLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLatLng();
  }

  void setLatLng() {
    print("setting");
    longitude = widget.lng;
    latitude = widget.lat;
    print(latitude);
    _myLocation = new CameraPosition(
        target: LatLng(latitude, longitude), zoom: 12, bearing: 15.0, tilt: 75.0);
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
        initialCameraPosition: _myLocation,
        onMapCreated: (GoogleMapController controller) {
          _setStyle(controller);
          print("map created");
          print(latitude);
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
        myLocationButtonEnabled: true,
        onTap: _mapTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(latitude);
          searchNearby(latitude, longitude, context);
        },
        label: Text('Places Nearby'),
        icon: Icon(Icons.place),
      ),
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
    print(latitude);
    setState(() {
      markers.clear();
      print(latitude);
    });
    String url = '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=15000&keyword=${widget.keyword}';
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
                  title: places[i].name,),
              onTap: () {
                showAlertDialog(context, places[i].name, places[i].rating.toString() + '\n' + places[i].vicinity.toString(), places[i].photos.elementAt(0).photoReference);
              },
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }

  showAlertDialog(BuildContext context, String placeName, String details, String url) {

    showDialog(
        context: context,
        builder: (BuildContext context) => NetworkGiffyDialog(
          image: Image.network("https://media.giphy.com/media/xUOwG3nVH6Of928xJm/source.gif", width: 100, height: 100,),
          title: Text(placeName, style: TextStyle(fontSize: 25.0, fontFamily: 'Pompiere',),),
          description: Text(details, style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,),
          entryAnimation: EntryAnimation.BOTTOM,
          onlyOkButton: true,
          buttonOkColor: Colors.blueAccent,
          buttonOkText: Text("Visit", style: TextStyle(color: Colors.white),),
        )
    );

  }

}


















