import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  final String title;
  Appbar({this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 17.0),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

}
