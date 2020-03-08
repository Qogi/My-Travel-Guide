import 'package:flutter/material.dart';
import 'package:my_travel_guide/components/places_search_map.dart';
import 'package:my_travel_guide/components/search_filter.dart';


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
            child: AppBar(
              title: Text(
                "",
                style: TextStyle(color: Colors.black, fontSize: 17.0),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              leading: new IconButton(icon: new Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
            )),
        body: PlacesSearchMap(
          keyword: keyword,
          lat: widget.lat,
          lng: widget.lng,
        ),
        endDrawer: SearchFilter(updateKeyWord),
      ),
    );
  }
}
