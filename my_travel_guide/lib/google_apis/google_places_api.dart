import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';
import 'package:google_maps_webservice/places.dart';

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
      apiKey: "AIzaSyAqcP5mwNElnbv51O6oHdG83jwn6LTaV24",
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

void searchCity(BuildContext context, String cityName) async {
  print("city search");
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyAqcP5mwNElnbv51O6oHdG83jwn6LTaV24");
  PlacesSearchResponse response = await places.searchByText(cityName);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CityPage(
                lat: response.results.elementAt(0).geometry.location.lat,
                lng: response.results.elementAt(0).geometry.location.lng,
              )));
}
