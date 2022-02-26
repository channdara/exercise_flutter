import 'package:flutter/material.dart';

class Option {
  final IconData icon;
  final String title;

  Option(this.icon, this.title);

  static final List<Option> tmpOptions = [
    Option(Icons.my_location, 'Near Me'),
    Option(Icons.restaurant, 'Type of Food'),
    Option(Icons.location_on, 'Location'),
  ];
}
