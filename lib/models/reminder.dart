import 'package:flutter/material.dart';

class Reminder {
  final int id;
  final String description;
  final double radius;
  final String placeType;
  final String place;
  final double latitude;
  final double longitude;
  final int lastNotifiedAt;

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'radius': radius,
        'place_type': placeType,
        'place': place,
        'latitude': latitude,
        'longitude': longitude,
        'last_notified_at': lastNotifiedAt
      };
}
