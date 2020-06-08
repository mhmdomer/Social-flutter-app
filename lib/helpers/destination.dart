import 'package:flutter/material.dart';

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'Home', Icons.home, Colors.teal),
  Destination(1, 'Business', Icons.business, Colors.cyan),
  Destination(2, 'School', Icons.school, Colors.orange),
  Destination(3, 'Flight', Icons.flight, Colors.blue)
];