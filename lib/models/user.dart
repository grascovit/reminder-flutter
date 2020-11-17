import 'package:flutter/material.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String avatarUrl;

  User(
      {this.id,
      @required this.firstName,
      this.lastName,
      @required this.email,
      this.phoneNumber,
      this.avatarUrl});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        phoneNumber: data['phone_number'],
        avatarUrl: data['avatar_url']);
  }
}
