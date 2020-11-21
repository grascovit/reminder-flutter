import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lembrete/screens/reminder_form.dart';

class NewReminderFloatingActionButton extends StatelessWidget {
  void _openNewReminderForm(BuildContext context) async {
    var message = await Navigator.pushNamed(context, ReminderForm.routeName,
        arguments: {'title': AppLocalizations.of(context).newReminder});

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
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
