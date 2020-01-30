import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/data.dart';


final databaseReference = Firestore.instance;
List<Doodle> list = new List();

List<Doodle> getData() {
  databaseReference
      .collection("VisitedPlaces")
      .document("cFfrdA6cnucjLV5UPrJJcawjLnf1")
      .collection("MyPlaces")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((docs) => list.add(Doodle(
          name: docs.data.values.toList().elementAt(0),
          time: docs.data.values.toList().elementAt(1),
        )));
  });
  print(list.length);
  return list;
}

List<Doodle> getTimelineLandmarks(){
  if(list.isEmpty){
    print(list.isEmpty);
    list = getData();
    return list;
  }else {
    return list;
  }
}

int numOfLandmarks() {

  return list.length;
}
