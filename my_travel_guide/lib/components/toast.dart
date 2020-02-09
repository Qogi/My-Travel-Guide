import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/layouts/home_page.dart';

class ToastMessage extends StatelessWidget {
  final String message;

  ToastMessage({this.message});

  void toast() {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
