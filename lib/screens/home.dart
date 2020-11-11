import 'package:flutter/material.dart';
import 'package:lembrete/repositories/reminder_repository.dart';
import 'package:lembrete/widgets/reminder_list.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/widgets/new_reminder_floating_action_button.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: StreamBuilder<List<Reminder>>(
        stream: ReminderRepository.list(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Reminder>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ReminderList(snapshot.data);
          }
        },
      ),
      floatingActionButton: NewReminderFloatingActionButton(),
    );
  }
}
