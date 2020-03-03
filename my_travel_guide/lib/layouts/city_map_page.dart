import 'package:flutter/material.dart';
import 'package:my_travel_guide/components/places_search_map.dart';
import 'package:my_travel_guide/components/search_filter.dart';
import 'package:my_travel_guide/components/app_bar.dart';

void main() => runApp(CityMapPage());

class CityMapPage extends StatefulWidget {
  final double lat;
  final double lng;
  final String keyword;
  CityMapPage({this.lat, this.lng, this.keyword});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CityMapPage();
  }
}

class _CityMapPage extends State<CityMapPage> {
  static String keyword = "Bakery";

  void updateKeyWord(String newKeyWord) {
    setState(() {
      keyword = newKeyWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Appbar(
              title: "City",
            )),
        body: PlacesSearchMap(keyword: keyword, lat: widget.lat, lng: widget.lng,),
        endDrawer: SearchFilter(updateKeyWord),
      ),
    );
  }
}
