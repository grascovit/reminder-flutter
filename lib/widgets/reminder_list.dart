import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lembrete/providers/reminder_provider.dart';
import 'package:lembrete/widgets/reminder_list_tile.dart';

class ReminderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (builder, model, child) {
        return ListView.builder(
            itemCount: model.reminders.length,
            itemBuilder: (context, index) {
              return ReminderListTile(model.reminders[index]);
            });
      },
    );
  }
}
