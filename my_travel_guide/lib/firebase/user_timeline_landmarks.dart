import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import '../firebase/data.dart';


final databaseReference = Firestore.instance;
List<Doodle> list = new List();

List<Doodle> getData() {
  print(getUserID());
  databaseReference
      .collection("VisitedPlaces")
      .document(getUserID())
      .collection("MyPlaces")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((docs) => list.add(Doodle(
          name: docs.data.values.toList().elementAt(0),
          time: docs.data.values.toList().elementAt(1),
        )));
  });
  return list;
}

void clearTimeline(){
  list.clear();
}

List<Doodle> getTimelineLandmarks(BuildContext context){
  if(list.isEmpty){
    list = getData();
    return list;
  }else {
    return list;
  }
}
