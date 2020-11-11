import 'package:flutter/material.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/widgets/reminder_list_tile.dart';

class ReminderList extends StatelessWidget {
  final List<Reminder> _reminders;

  ReminderList(this._reminders);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          return ReminderListTile(_reminders[index]);
        });
  }
}
