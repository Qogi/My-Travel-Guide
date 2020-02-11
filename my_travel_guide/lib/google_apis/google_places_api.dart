import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/timezone.dart';

String landmarkName,
    landmarkWebsite,
    landmarkNumber,
    landmarkAddress,
    landmarkRating,
    landmarkOpeningHours;
Data data;

List<String> landmarkInformation;

PlacePicker placePickerIntent(BuildContext context, String searchType) {
  if (searchType == "landmark") {
    return PlacePicker(
      apiKey: "AIzaSyDVuZm4ZWwkzJdxeSOFEBWk37srFby2e4Q",
      onPlacePicked: (result) {
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
                    ))).whenComplete(() {
          SystemNavigator.pop();
        });
      },
      initialPosition: LatLng(48.858372, 2.294481),
      useCurrentLocation: true,
    );
  }
}

void searchCity(BuildContext context) async {
  print("city search");
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyDVuZm4ZWwkzJdxeSOFEBWk37srFby2e4Q");
  PlacesSearchResponse reponse = await places.searchByText("Paris");
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CityPage(lat: reponse.results.elementAt(0).geometry.location.lat, lng: reponse.results.elementAt(0).geometry.location.lng, keyword: "Bakery",
              )));
}
