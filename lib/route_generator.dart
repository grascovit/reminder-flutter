import 'package:flutter/material.dart';
import 'package:lembrete/screens/home.dart';
import 'package:lembrete/screens/login.dart';
import 'package:lembrete/screens/reminder_form.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map;

    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case ReminderForm.routeName:
        return MaterialPageRoute(
            builder: (_) => ReminderForm(
                title: arguments['title'], reminder: arguments['reminder']));
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
