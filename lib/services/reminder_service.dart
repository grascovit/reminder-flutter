import 'package:dio/dio.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/network/api_client.dart';

class ReminderService {
  static Future<List<Reminder>> list() async {
    final Response response =
        await ApiClient.authenticatedClient.get('reminders');

    return (response.data as List)
        .map((reminder) => Reminder.fromMap(reminder))
        .toList();
  }

  static Future<Reminder> create(Reminder reminder) async {
    final Response response = await ApiClient.authenticatedClient
        .post('reminders', data: reminder.toJson());

    return Reminder.fromMap(response.data);
  }

  static Future<void> delete(int id) async {
    await ApiClient.authenticatedClient.delete('reminders/$id');
  }
}
