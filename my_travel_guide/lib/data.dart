import 'package:flutter/material.dart';

class Doodle {
  final String name;
  final String time;
  final String doodle;
  final Color iconBackground;

  const Doodle(
      {this.name,
      this.time,
      this.doodle,
      this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
      name: "Pyramids of Giza",
      time: "19/11/2019",
      doodle:
          "https://images.unsplash.com/photo-1539650116574-8efeb43e2750?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ",
      iconBackground: Colors.lightBlue),
  Doodle(
      name: "Al Aqsa",
      time: "20/10/2019",
      doodle:
          "https://images.unsplash.com/photo-1542743408-218cc173cda0?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ",
      iconBackground: Colors.lightBlue),
];
