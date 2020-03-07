import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/layouts/city_page.dart';
import 'package:my_travel_guide/models/slideshow_values.dart';

final List<String> slideshowList = [
  'Petra',
  'Rome',
  'Pyramids of Giza',
  'Jerusalem'
];

class ImageSlideshow extends StatelessWidget {
  bool isButtonVisible = true;

  ImageSlideshow({this.isButtonVisible});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(
      viewportFraction: 0.9,
      autoPlayAnimationDuration: Duration(milliseconds: 1000),
      autoPlayCurve: Curves.easeInOut,
      aspectRatio: 2.0,
      autoPlay: true,
      height: 300.0,
      items: slideshowList.map(
        (placeName) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(getPlaceURL(placeName)),
                          fit: BoxFit.fill
                        )),
                  ),
                ),
                Visibility(
                    visible: isButtonVisible ?? true,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          placeName,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityPage(
                                        lat: getPlaceLatLng(placeName).elementAt(0),
                                        lng: getPlaceLatLng(placeName).elementAt(1),
                                        name: placeName,
                                        imageRef: getPlaceNetworkURL(placeName),
                                      )));
                        },
                      ),
                    ))
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}