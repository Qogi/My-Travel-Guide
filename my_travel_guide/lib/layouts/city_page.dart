import 'package:flutter/material.dart';
import 'package:my_travel_guide/components/places_search_map.dart';
import 'package:my_travel_guide/components/search_filter.dart';
import 'package:my_travel_guide/components/app_bar.dart';

void main() => runApp(GoogleMap());

class GoogleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMap();
  }
}

class _GoogleMap extends State<GoogleMap> {
  static String keyword = "Bakery";

  void updateKeyWord(String newKeyWord) {
    print(newKeyWord);
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
        body: PlacesSearchMap(keyword),
        endDrawer: SearchFilter(updateKeyWord),
      ),
    );
  }
}
