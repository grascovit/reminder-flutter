import 'package:flutter/material.dart';

class Reminder {
  String description;
  String place;
  String placeType;
  double latitude;
  double longitude;
  double radius;
  int lastNotifiedAt;

  Reminder(
      {@required this.description,
      this.place,
      this.placeType,
      this.latitude,
      this.longitude,
      @required this.radius});
}
