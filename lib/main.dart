import 'package:flutter/material.dart';
import 'package:lembrete/screens/home.dart';
import 'package:lembrete/screens/reminder_form.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Reminder',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amberAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ReminderForm.routeName: (context) => ReminderForm()
        });
  }
}
