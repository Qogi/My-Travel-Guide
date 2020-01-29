import 'package:flutter/material.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

TimelineModel centerTimelineBuilder(BuildContext context, int i){
  final doodle = doodles[i];
  
  final textTheme = Theme.of(context).textTheme;
  
  return TimelineModel(
    Card(
      elevation: 10.0,
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(doodle.doodle),
            const SizedBox(
              height: 8.0,
            ),
            Text(doodle.time, style: textTheme.caption),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              doodle.name,
              style: TextStyle(fontFamily: 'Pompiere', fontWeight: FontWeight.bold, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ),
    position: i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
    isFirst: i == 0,
    isLast: i == doodles.length,
    iconBackground: doodle.iconBackground,
  );
}











































