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

String baseURL =
    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=';
String apiKEY = '&key=AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A';
const String baseUrl =
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

String landmarkName,
    landmarkWebsite,
    landmarkNumber,
    landmarkAddress,
    landmarkRating,
    landmarkOpeningHours;
Data data;

List<String> landmarkInformation;
List<Result> cityLandmarks = new List();

String _buildRatingStars(double rating) {
  String stars = '';
  for (int i = 0; i < rating.round(); i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return stars;
}

PlacePicker placePickerIntent(BuildContext context) {
  return PlacePicker(
    apiKey: "AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A",
    onPlacePicked: (result) {
      print(baseURL + result.photos.elementAt(0).photoReference + apiKEY);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandmarkPage(
                    data: Data(
                        text: result.name,
                        address: result.formattedAddress,
                        number: result.internationalPhoneNumber,
                        website: result.website,
                        rating:
                            _buildRatingStars(result.rating.toDouble()) ?? " ",
                        openingHours: result.openingHours.weekdayText
                            .elementAt(DateTime.now().weekday - 1),
                        photoURL: baseURL +
                            result.photos.elementAt(0).photoReference +
                            apiKEY),
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
                imageRef: baseURL +
                    response.results
                        .elementAt(0)
                        .photos
                        .elementAt(0)
                        .photoReference +
                    apiKEY,
                name: response.results.elementAt(0).formattedAddress,
              )));
}
