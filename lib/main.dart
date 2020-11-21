import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:lembrete/providers/reminder_provider.dart';
import 'package:lembrete/screens/login.dart';
import 'package:lembrete/constants.dart';
import 'package:lembrete/route_generator.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(
      ChangeNotifierProvider(create: (_) => ReminderProvider(), child: App()));
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
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
