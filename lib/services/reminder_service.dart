import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/network/api_client.dart';

class ReminderService {
  static Future<List<Reminder>> list() async {
    Response response = await ApiClient.authenticatedClient.get('reminders');

    return (response.data as List)
        .map((reminder) => Reminder.fromMap(reminder))
        .toList();
  }
}
