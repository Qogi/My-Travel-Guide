import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _MyPage createState() => new _MyPage();
}

class _MyPage extends State<Page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          RowsAndColumns()
//          GridView.count(
//            crossAxisCount: 2,
//            primary: false,
//            padding: EdgeInsets.only(left: 20, right: 20),
//            crossAxisSpacing: 30.0,
//            mainAxisSpacing: 30.0,
//            shrinkWrap: true,
//            children: <Widget>[
////              _buildCard('assets/images/options.png', "Landmarks"),
////              _buildCard('assets/images/near_by_landmarks.png', "Cities"),
////              _buildCard('assets/images/timeline.png', "Timeline"),
////              _buildCard('assets/images/options.png', "Landmarks"),
//
//            ],
//          )
        ],
      ),
    );
  }

//  Widget _buildCard(String url, String name) {
//    return Container(
//        color: Colors.grey,
//        height: 100,
//        child: Card(
//          shape:
//              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//          elevation: 7.0,
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Stack(children: <Widget>[
//                Container(
//                  height: 110.0,
//                  width: 110.0,
//                  decoration: BoxDecoration(
//                      image: DecorationImage(image: AssetImage(url))),
//                )
//              ]),
//              Text(
//                name,
//                style: TextStyle(
//                    fontFamily: 'Quicksand',
//                    fontWeight: FontWeight.bold,
//                    fontSize: 15.0),
//              ),
//            ],
//          ),
//        ));
//  }
}

class RowsAndColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Column(children: [
              _buildCard('Landmark', 'assets/images/options.png'),
              _buildCard('Timeline', 'assets/images/timeline_cropped.png')
            ]),
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              _buildCard('Cities', 'assets/images/near_by_landmarks.png'),
              _buildCard('Camera', 'assets/images/camera.png')
            ],
          )),
        ]),
      ),
    );
  }

  Widget _buildCard(String name, String imageURL) {
    return Container(
      height: 160.0,
      width: 160.0,
      padding: EdgeInsets.only(top: 10),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: 110.0,
                width: 110.0,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imageURL))),
              )
            ]),
            Text(
              name,
              style: TextStyle(
                  fontFamily: 'Pompiere',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
