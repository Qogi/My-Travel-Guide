import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:my_travel_guide/apis/google_places_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchFilter extends StatefulWidget {
  final Function updateKeyword;

  SearchFilter(this.updateKeyword);

  @override
  State<StatefulWidget> createState() {
    return _SearchFilter(updateKeyword);
  }
}

class _SearchFilter extends State<SearchFilter> {
  List<String> filterOptions = <String>[
    "Bakery",
    "Bar",
    "Cafe",
    "Restaurant",
    "Supermarket",
    "point+of+interest",
    "museum"
  ];

  static const String _KEY_SELECTED_POSITION = "position";
  static const String _KEY_SELECTED_VALUE = "value";

  int _selectedPosition = 0;
  final Function updateKeyword;

  _SearchFilter(this.updateKeyword);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              selected: _selectedPosition == 1,
              leading: Icon(Icons.local_bar),
              title: Text(filterOptions[1]),
              onTap: () {
                _saveKeywordPreference(1);
              },
              trailing: _getIcon(1),
            ),
            ListTile(
              selected: _selectedPosition == 2,
              leading: Icon(Icons.local_cafe),
              title: Text(filterOptions[2]),
              onTap: () {
                _saveKeywordPreference(2);
              },
              trailing: _getIcon(2),
            ),
            ListTile(
              selected: _selectedPosition == 3,
              leading: Icon(Icons.local_dining),
              title: Text(filterOptions[3]),
              onTap: () {
                _saveKeywordPreference(3);
              },
              trailing: _getIcon(3),
            ),
            ListTile(
              selected: _selectedPosition == 4,
              leading: Icon(Icons.local_grocery_store),
              title: Text(filterOptions[4]),
              onTap: () {
                _saveKeywordPreference(4);
              },
              trailing: _getIcon(4),
            ),
            ListTile(
              selected: _selectedPosition == 5,
              leading: Icon(Icons.place),
              title: Text("Tourist Attractions"),
              onTap: () {
                _saveKeywordPreference(5);
              },
              trailing: _getIcon(5),
            ),
            ListTile(
              selected: _selectedPosition == 6,
              leading: Icon(Icons.account_balance),
              title: Text("Museum"),
              onTap: () {
                _saveKeywordPreference(6);
              },
              trailing: _getIcon(6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIcon(int value) {
    return Builder(
      builder: (BuildContext context) {
        if (value == _selectedPosition) {
          return Icon(Icons.check);
        } else {
          return SizedBox(
            width: 50,
          );
        }
      },
    );
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPosition = prefs.getInt(_KEY_SELECTED_POSITION) ?? 0;
    });
  }

  void _saveKeywordPreference(int position) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPosition = position;
      prefs.setString(_KEY_SELECTED_VALUE, filterOptions[position]);
      prefs.setInt(_KEY_SELECTED_POSITION, position);
      updateKeyword(filterOptions[position]);
    });
  }
}
