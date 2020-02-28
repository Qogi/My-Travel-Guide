import 'dart:async';
import 'dart:convert';
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
  static const String _API_KEY = 'AIzaSyDVuZm4ZWwkzJdxeSOFEBWk37srFby2e4Q';
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(latitude);
          searchNearby(latitude, longitude);
        },
        label: Text('Places Nearby'),
        icon: Icon(Icons.place),
      ),
    );
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby(double latitude, double longitude) async {
    print(latitude);
    setState(() {
      markers.clear();
      print(latitude);
    });
    String url = '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=${widget.keyword}';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data) {
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
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }
}
