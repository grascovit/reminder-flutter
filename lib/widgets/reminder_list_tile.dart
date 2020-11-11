import 'package:flutter/material.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/repositories/reminder_repository.dart';
import 'package:lembrete/screens/reminder_form.dart';

class ReminderListTile extends StatelessWidget {
  final Reminder _reminder;

  ReminderListTile(this._reminder);

  void _openEditReminderForm(BuildContext context) {
    Navigator.pushNamed(context, ReminderForm.routeName,
        arguments: {'title': 'Edit Reminder', 'reminder': _reminder});
  }

  Future<void> _deleteReminder(BuildContext context) async {
    await ReminderRepository.delete(_reminder.id);
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Reminder successfully deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
                _reminder.place == null || _reminder.place.isEmpty
                    ? _reminder.placeType
                    : _reminder.place,
                style: Theme.of(context).textTheme.headline6),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                'Up to ${_reminder.radius.toInt()}m away',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              _reminder.description,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7), fontSize: 16.0),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => _openEditReminderForm(context),
                child: Text('Edit'.toUpperCase()),
              ),
              TextButton(
                onPressed: () => _deleteReminder(context),
                child: Text('Delete'.toUpperCase(),
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
