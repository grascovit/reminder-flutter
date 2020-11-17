import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lembrete/screens/home.dart';
import 'package:lembrete/screens/login.dart';
import 'package:lembrete/screens/reminder_form.dart';
import 'package:lembrete/constants.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Reminder',
        theme: ThemeData(
          primarySwatch: primarySwatch,
          accentColor: Colors.amberAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          HomePage.routeName: (context) => HomePage(),
          ReminderForm.routeName: (context) => ReminderForm()
        });
  }
}
