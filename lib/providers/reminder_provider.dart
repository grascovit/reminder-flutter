import 'package:flutter/material.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/services/reminder_service.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<List<Reminder>> fetchReminders() async {
    _reminders = await ReminderService.list();

    return _reminders;
  }

  Future<void> create(Reminder reminder) async {
    Reminder persistedReminder = await ReminderService.create(reminder);
    _add(persistedReminder);
  }

  Future<void> update(Reminder oldReminder) async {
    Reminder newReminder = await ReminderService.update(oldReminder);
    _replace(oldReminder, newReminder);
  }

  Future<void> delete(Reminder reminder) async {
    await ReminderService.delete(reminder.id);
    _remove(reminder);
  }

  void _add(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void _replace(Reminder oldReminder, Reminder newReminder) {
    int index = _reminders
        .indexWhere((Reminder reminder) => reminder.id == oldReminder.id);
    _reminders[index] = newReminder;
    notifyListeners();
  }

  void _remove(Reminder reminder) {
    _reminders.remove(reminder);
    notifyListeners();
  }
}
