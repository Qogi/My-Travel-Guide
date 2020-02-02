import 'package:flutter/material.dart';
import 'package:my_travel_guide/firebase/user_timeline_landmarks.dart';
import 'package:timeline_list/timeline.dart';
import '../components/timeline_item.dart';

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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              title: Text(
                "Timeline",
                style: TextStyle(color: Colors.black, fontSize: 17.0),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
            )),
        body: PageView(
          children: <Widget>[timelineModel()],
        ));
  }

  timelineModel() => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: getTimelineLandmarks(context).length,
      position: TimelinePosition.Center);
}
