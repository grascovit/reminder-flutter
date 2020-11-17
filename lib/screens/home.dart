import 'package:flutter/material.dart';
import 'package:lembrete/services/reminder_service.dart';
import 'package:lembrete/widgets/reminder_list.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/widgets/new_reminder_floating_action_button.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Reminder>> _fetchReminders() async {
    return await ReminderService.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: FutureBuilder<List<Reminder>>(
          future: _fetchReminders(),
          builder:
              (BuildContext builder, AsyncSnapshot<List<Reminder>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ReminderList(snapshot.data ?? []);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: NewReminderFloatingActionButton(),
    );
  }
}
