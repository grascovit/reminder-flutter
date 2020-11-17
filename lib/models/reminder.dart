import 'package:flutter/material.dart';

class Reminder {
  int id;
  String description;
  double radius;
  String placeType;
  String place;
  double latitude;
  double longitude;
  int lastNotifiedAt;

  Reminder(
      {this.id,
      @required this.description,
      @required this.radius,
      this.placeType,
      this.place,
      this.latitude,
      this.longitude,
      this.lastNotifiedAt});

  factory Reminder.fromMap(Map<String, dynamic> data) {
    return Reminder(
        id: data['id'],
        description: data['description'],
        radius: data['radius'].toDouble(),
        placeType: data['place_type'],
        place: data['place'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        lastNotifiedAt: data['last_notified_at']);
  }
}
