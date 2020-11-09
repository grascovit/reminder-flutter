import 'package:flutter/material.dart';
import 'package:lembrete/widgets/reminder_list.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/widgets/new_reminder_floating_action_button.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Reminder> _reminders = [
    Reminder(description: 'Buy milk', placeType: 'Bakery', radius: 100.0),
    Reminder(
        description: 'Buy Alivium 600mg',
        placeType: 'Drugstore',
        radius: 500.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: Builder(
        builder: (context) {
          return ReminderList(_reminders);
        },
      ),
      floatingActionButton: NewReminderFloatingActionButton(),
    );
  }
}
