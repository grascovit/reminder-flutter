import 'package:flutter/material.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/services/reminder_service.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<List<Reminder>> fetchReminders() async {
    _reminders = await ReminderService.list();
    notifyListeners();

    return _reminders;
  }

  Future<void> create(Reminder reminder) async {
    Reminder _reminder = await ReminderService.create(reminder);
    add(_reminder);
  }

  Future<void> delete(Reminder reminder) async {
    await ReminderService.delete(reminder.id);
    remove(reminder);
  }

  void add(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void remove(Reminder reminder) {
    _reminders.remove(reminder);
    notifyListeners();
  }
}
