import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/providers/reminder_provider.dart';
import 'package:lembrete/widgets/new_reminder_floating_action_button.dart';
import 'package:lembrete/widgets/reminder_list.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Reminder>> _reminders;

  @override
  void initState() {
    super.initState();
    _reminders = context.read<ReminderProvider>().fetchReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: FutureBuilder(
          future: _reminders,
          builder:
              (BuildContext builder, AsyncSnapshot<List<Reminder>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ReminderList();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: NewReminderFloatingActionButton(),
    );
  }
}
