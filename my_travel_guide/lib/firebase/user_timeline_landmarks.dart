import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import '../models/landmark.dart';

final databaseReference = Firestore.instance;
List<Landmark> list = new List();
Map<String, String> landmarkMap = new Map<String, String>();

List<Landmark> getData() {
  print(getUserID());
  databaseReference
      .collection("VisitedPlaces")
      .document(getUserID())
      .collection("MyPlaces")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((docs) => list.add(Landmark(
          name: docs.data.values.toList().elementAt(0),
          time: docs.data.values.toList().elementAt(1),
        )));
  });
  return list;
}

void addLandmarkToTimeline(String placeID, String landmarkName, String dataVisited){
  landmarkMap["Place Name"] = landmarkName;
  landmarkMap["Date Visited"] = dataVisited;
  landmarkMap["ID"] = placeID;

  databaseReference
    .collection("VisitedPlaces")
    .document(getUserID())
    .collection("MyPlaces")
    .add(landmarkMap)
    .whenComplete(() {print("Added");});
}

void clearTimeline(){
  list.clear();
}

List<Landmark> getTimelineLandmarks(BuildContext context){
//  if(list.isEmpty){
//    list = getData();
//    return list;
//  }else {
//    return list;
//  }

  return list;
}
