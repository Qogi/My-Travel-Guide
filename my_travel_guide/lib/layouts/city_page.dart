import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travel_guide/apis/google_places_api.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                child: Hero(
                  tag: "assets/images/petra.jpg",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage("assets/images/petra.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      width: 100,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                        cursorColor: Colors.white,
                        onSubmitted: (String cityName) {
                          searchCity(context,cityName );
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Search...",
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Petra",
                      style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white70,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Jordan",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 20.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: IconButton(
                  icon: Icon(Icons.map),
                  color: Colors.white,
                  iconSize: 30.0,
                  onPressed: () => {print("pressed")},
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  child: Text(
                                    "Petra",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "\$30",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              "Opening Hours",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "⭐⭐⭐⭐",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          width: 110.0,
                          image: AssetImage("assets/images/sphinx.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
