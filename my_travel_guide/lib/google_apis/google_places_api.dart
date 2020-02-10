import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/landmark_information.dart';
import 'package:my_travel_guide/layouts/landmark_page.dart';

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
  } else if (searchType == "city") {
    print("city search");
    return PlacePicker(
      apiKey: "AIzaSyDVuZm4ZWwkzJdxeSOFEBWk37srFby2e4Q",
      onPlacePicked: (result) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CityPage(lat: 48.8566,lng: 2.3522,)));
      },
      initialPosition: LatLng(48.858372, 2.294481),
      useCurrentLocation: true,
    );
  }
}
