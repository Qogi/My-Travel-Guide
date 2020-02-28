import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:my_travel_guide/models/place_response.dart';

import 'package:http/http.dart' as http;
import 'package:my_travel_guide/models/result.dart';

String landmarkName,
    landmarkWebsite,
    landmarkNumber,
    landmarkAddress,
    landmarkRating,
    landmarkOpeningHours;
Data data;

List<String> landmarkInformation;

PlacePicker placePickerIntent(BuildContext context) {
  return PlacePicker(
    apiKey: "AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A",
    onPlacePicked: (result) {
      print(result.photos.elementAt(0));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandmarkPage(
                    data: Data(
                        text: result.name,
                        address: result.formattedAddress,
                        number: result.internationalPhoneNumber,
                        website: result.website,
                        rating: result.rating.toString() ?? "No Rating",
                        openingHours: result.openingHours.weekdayText
                            .elementAt(DateTime.now().weekday - 1)),
                    isVisible: true,
                  ))).whenComplete(() {
        SystemNavigator.pop();
      });
    },
    initialPosition: LatLng(48.858372, 2.294481),
    useCurrentLocation: true,
  );
}

void searchCity(BuildContext context, String cityName) async {
  print("city search");
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A");
  PlacesSearchResponse response = await places.searchByText(cityName);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CityPage(
                lat: response.results.elementAt(0).geometry.location.lat,
                lng: response.results.elementAt(0).geometry.location.lng,
              )));
}
//
//void placePhoto() async {
//  print("here2");
//  String url =
//      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAAAG0FIRNBTGnrLOcDWP5PX67kenTaAH_yeQmVromQyxTaSnAcEj7RcrQXhTxNqGmrdZoPZUMgAJClVvtYrhNO03c8jJIQMc6OtzJSUho0zN96bzb0bqC5JuUZqHgVS_3XEhBhVHg2CD43tA5GWhV8qnhuGhQucocCuCl31jAqgM0MR6sem4ZtmA&key=AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A';
//  fetchPhotos(client, url)
//}
//
//Future<http.Response> fetchPhotos(http.Client client, String url) async {
//  return client.get(url);
//}
//
//void _handleResponse(data) {
//  print("here");
//  print(data);
//  // bad api key or otherwise
//  if (data['status'] == "REQUEST_DENIED") {
//    print('REQUEST_DENIED');
//    // success
//  } else if (data['status'] == "OK") {
//    List<Result> results = PlaceResponse.parseResults(data['results']);
//    print(results);
//  } else {
//    print(data);
//  }
//}




























