import 'package:flutter/material.dart';
import 'package:my_travel_guide/firebase/cloud_firestore.dart';
import 'package:timeline_list/timeline.dart';
import '../components/timeline_item.dart';
import 'package:my_travel_guide/components/app_bar.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Appbar(title: "Timeline")),
        body: PageView(
          children: <Widget>[timelineModel()],
        ));
  }

  timelineModel() => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: getTimelineLandmarks(context).length,
      position: TimelinePosition.Center);
}
