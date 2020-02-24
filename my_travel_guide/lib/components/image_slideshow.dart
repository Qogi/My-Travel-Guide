import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/Constant/SlideshowConstants.dart';
import 'package:my_travel_guide/layouts/city_page.dart';

final List<String> imgList = [
  'assets/images/pyramids.jpg',
  'https://images.unsplash.com/photo-1542743408-218cc173cda0?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ',
  'https://images.unsplash.com/photo-1501232060322-aa87215ab531?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ',
  'https://images.unsplash.com/photo-1503970999490-4404449dc349?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ'
];

final List<String> slideshowList = [
  'Petra',
  'Rome',
  'Pyramids of Giza',
  'Jerusalem'
];

class ImageSlideshow extends StatelessWidget {
  bool isVisible = true;

  ImageSlideshow({this.isVisible});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(
      viewportFraction: 0.9,
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
                    visible: isVisible ?? true,
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
                                        keyword: "bakery",
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