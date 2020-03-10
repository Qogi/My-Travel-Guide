import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:my_travel_guide/models/result.dart';

String baseImageUrl =
    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=';
String apiKeyBase = '&key=';
const String baseUrl =
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

Data data;

List<String> landmarkInformation;
List<Result> cityLandmarks = new List();

String _buildRatingStars(PickResult result) {

  if(result.rating != null){
    String stars = '';
    for (int i = 0; i < result.rating.round(); i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return stars;
  }

  return "Information Not Available";
}

PlacePicker placePickerIntent(BuildContext context, String apiKey) {
  return PlacePicker(
    apiKey: apiKey,
    onPlacePicked: (result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandmarkPage(
                    data: Data(
                        id: result.placeId,
                        text: result.name ?? "Landmark",
                        address: getLandmarkAddress(result) ,
                        number: getLandmarkNumber(result),
                        website: getLandmarkWebsite(result),
                        rating: _buildRatingStars(result),
                        openingHours: getLandmarkOpeningHours(result.openingHours),
                        lat: result.geometry.location.lat,
                        lng: result.geometry.location.lng,
                        photoURL: baseImageUrl + result.photos.elementAt(0).photoReference + "&key=" + apiKey),
                  ))).whenComplete(() {
        SystemNavigator.pop();
      });
    },
    initialPosition: LatLng(48.858372, 2.294481),
    useCurrentLocation: true,
  );
}

String getLandmarkWebsite(PickResult result) {
  if(result.website != null){
    return result.website.toString();
  }else{
    return "Information Not Available";
  }
}

String getLandmarkAddress(PickResult result) {
  if(result.formattedAddress != null){
    return result.formattedAddress.toString();
  }else{
    return "Information Not Available";
  }
}

String getLandmarkNumber(PickResult result) {
  if(result.formattedPhoneNumber != null){
    return result.formattedPhoneNumber.toString();
  }else{
    return "Information Not Available";
  }
}

String getLandmarkOpeningHours(OpeningHoursDetail openingHoursDetail){
  if(openingHoursDetail != null){
    return openingHoursDetail.weekdayText.elementAt(DateTime.now().weekday - 1);
  }else{
    return "Information Not Available";
  }
}

void searchCity(BuildContext context, String cityName, String apiKey) async {
  print("city search");
  final places =
      new GoogleMapsPlaces(apiKey: apiKey);
  PlacesSearchResponse response = await places.searchByText(cityName);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CityPage(
                lat: response.results.elementAt(0).geometry.location.lat,
                lng: response.results.elementAt(0).geometry.location.lng,
                imageRef: baseImageUrl +
                    response.results
                        .elementAt(0)
                        .photos
                        .elementAt(0)
                        .photoReference + "&key=" + apiKey,
                name: response.results.elementAt(0).formattedAddress,
              )));
}





























