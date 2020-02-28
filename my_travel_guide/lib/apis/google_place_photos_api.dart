import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAAAG0FIRNBTGnrLOcDWP5PX67kenTaAH_yeQmVromQyxTaSnAcEj7RcrQXhTxNqGmrdZoPZUMgAJClVvtYrhNO03c8jJIQMc6OtzJSUho0zN96bzb0bqC5JuUZqHgVS_3XEhBhVHg2CD43tA5GWhV8qnhuGhQucocCuCl31jAqgM0MR6sem4ZtmA&key=AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A');
  print(response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

void main() => runApp(PhotosApi());

class PhotosApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Image.network(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAAAG0FIRNBTGnrLOcDWP5PX67kenTaAH_yeQmVromQyxTaSnAcEj7RcrQXhTxNqGmrdZoPZUMgAJClVvtYrhNO03c8jJIQMc6OtzJSUho0zN96bzb0bqC5JuUZqHgVS_3XEhBhVHg2CD43tA5GWhV8qnhuGhQucocCuCl31jAqgM0MR6sem4ZtmA&key=AIzaSyDvTSnPtwX2IdzTnHmjPdWwnGRY0BQHN9A'
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}