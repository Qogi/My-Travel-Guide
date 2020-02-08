import 'package:flutter/material.dart';
import 'package:my_travel_guide/landmark_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

int _upVotes = 0, _downVotes = 0, _count = 0;
String name = "Null";
Data data;

class MyApp extends StatefulWidget {
  final String label;
  MyApp({this.label});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<MyApp> {
  SharedPreferences prefs;

  initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    _upVotes = prefs.getInt('upVotes');
    _downVotes = prefs.getInt('downVotes');
    _count = _upVotes + _downVotes;
    setPreviousState();
  }

  void setPreviousState() {
    setState(() {
      _upVotes;
      _downVotes;
      _count;
    });
  }

  void _increase() {
    name = "Mahmoud";
    prefs.setString("name", name);
  }

  void _decrease() {
    setState(() {
      _downVotes++;
      _count++;
    });
    prefs.setInt('downVotes', _downVotes);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Poll App',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.label),
          backgroundColor: new Color(0xFF8B1122),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(name),
              new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  makeAButton('+1', _increase),
                  makeAButton('-1', _decrease),
                ],
              ),
              makeATextWidget("Down Votes :",  _downVotes),
            ],
          ),
        ),
        bottomNavigationBar: new BottomAppBar(
          color: new Color(0xFF8B1122),
          child: new Text(
            '$_count votes casted',
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeAButton(String label, f()) {
  return new RaisedButton(
    child: new Text(label,
        style: new TextStyle(
          fontSize: 20.0,
        )),
    color: new Color(0xFF8B1122),
    textColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    elevation: 10.0,
    splashColor: Colors.white70,
    onPressed: f,
  );
}

Widget makeATextWidget(String txt, int value) {
  return new Text(
    "$txt : $value",
    style: new TextStyle(
      fontSize: 25.0,
      color: new Color(0xFF8B1122),
      fontWeight: FontWeight.w600,
    ),
  );
}
