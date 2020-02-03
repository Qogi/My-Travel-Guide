import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

String landmarkName, landmarkWebsite, landmarkNumber, landmarkAddress, landmarkRating;

PlacePicker placePickerIntent(BuildContext context){
  return PlacePicker(
    apiKey: 'AIzaSyDVuZm4ZWwkzJdxeSOFEBWk37srFby2e4Q',
    onPlacePicked: (result) {
      print(result.formattedAddress);
      Navigator.of(context).pop();
    },
    initialPosition: LatLng(48.858372, 2.294481),
    useCurrentLocation: true,
  );
}