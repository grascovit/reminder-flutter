import 'package:flutter/material.dart';
import 'package:lembrete/screens/reminder_form.dart';

class NewReminderFloatingActionButton extends StatelessWidget {
  void _openNewReminderForm(BuildContext context) async {
    dynamic reminder = await Navigator.pushNamed(
        context, ReminderForm.routeName,
        arguments: {'title': 'New Reminder'});

    if (reminder != null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Reminder successfully created')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openNewReminderForm(context),
      child: Icon(Icons.add),
    );
  }
}
