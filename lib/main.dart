import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lembrete/screens/home.dart';
import 'package:lembrete/screens/reminder_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
