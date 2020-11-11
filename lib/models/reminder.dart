import 'package:flutter/material.dart';

class Reminder {
  final String id;
  final String description;
  final String place;
  final String placeType;
  final double latitude;
  final double longitude;
  final double radius;
  final int lastNotifiedAt;

  Reminder(
      {this.id,
      @required this.description,
      this.place,
      this.placeType,
      this.latitude,
      this.longitude,
      @required this.radius,
      this.lastNotifiedAt});

  factory Reminder.fromMap(Map<String, dynamic> data, String documentId) {
    return Reminder(
        id: documentId,
        description: data['description'],
        place: data['place'],
        placeType: data['placeType'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        radius: data['radius'].toDouble(),
        lastNotifiedAt: data['lastNotifiedAt']);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'place': place,
      'placeType': placeType,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'lastNotifiedAt': lastNotifiedAt
    };
  }
}
