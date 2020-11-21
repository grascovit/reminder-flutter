import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:lembrete/models/reminder.dart';
import 'package:lembrete/providers/reminder_provider.dart';

class ReminderForm extends StatefulWidget {
  final String title;
  final Reminder reminder;
  static const String routeName = 'reminderForm';

  ReminderForm({this.title, this.reminder});

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  int _id;
  double _radius = 100;
  String _reminderType;
  String _placeType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  static const String placeReminder = 'placeReminder';
  static const String placeTypeReminder = 'placeTypeReminder';

  void _saveReminder(BuildContext context) {
    if (_formKey.currentState.validate()) {
      String message;
      final reminder = Reminder(
          id: _id,
          description: _descriptionController.text,
          place: _placeController.text,
          placeType: _placeType,
          radius: _radius);

      if (_id == null) {
        context.read<ReminderProvider>().create(reminder);
        message = AppLocalizations.of(context).reminderCreated;
      } else {
        context.read<ReminderProvider>().update(reminder);
        message = AppLocalizations.of(context).reminderUpdated;
      }

      Navigator.pop(context, message);
    }
  }

  @override
  void initState() {
    super.initState();

    final reminder = widget.reminder;

    if (reminder != null) {
      _id = reminder.id;
      _descriptionController.text = reminder.description ?? '';
      _placeController.text = reminder.place ?? '';
      _radius = reminder.radius;
      _placeType = reminder.placeType;
      _reminderType = reminder.place == null || reminder.place.isEmpty
          ? placeTypeReminder
          : placeReminder;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Builder(
          builder: (context) {
            return ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                            child: Text(
                              AppLocalizations.of(context).descriptionLabel,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 16.0, 8.0),
                            child: TextFormField(
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .description,
                                    border: OutlineInputBorder(),
                                    helperText: AppLocalizations.of(context)
                                        .descriptionHelper),
                                controller: _descriptionController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return AppLocalizations.of(context)
                                        .descriptionMissing;
                                  }

                                  return null;
                                }),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                            child: Text(
                              AppLocalizations.of(context).reminderTypeLabel,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          RadioListTile(
                            title:
                                Text(AppLocalizations.of(context).placeLabel),
                            value: placeReminder,
                            groupValue: _reminderType,
                            onChanged: (value) {
                              setState(() {
                                _reminderType = value;
                                _placeType = null;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(
                                AppLocalizations.of(context).placeTypeLabel),
                            value: placeTypeReminder,
                            groupValue: _reminderType,
                            onChanged: (value) {
                              setState(() {
                                _reminderType = value;
                                _placeController.value = TextEditingValue.empty;
                              });
                            },
                          ),
                          Visibility(
                              visible: _reminderType == placeTypeReminder,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 8.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .placeTypeDropdownLabel,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: DropdownButtonFormField(
                                        value: _placeType,
                                        validator: (value) {
                                          if (value == null) {
                                            return AppLocalizations.of(context)
                                                .placeTypeMissing;
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                        hint: Text(AppLocalizations.of(context)
                                            .placeTypeHint),
                                        items: [
                                          DropdownMenuItem(
                                              child: Text('Bakery'),
                                              value: 'bakery'),
                                          DropdownMenuItem(
                                              child: Text('Drugstore'),
                                              value: 'drugstore'),
                                          DropdownMenuItem(
                                              child: Text('Supermarket'),
                                              value: 'supermarket'),
                                        ],
                                        onChanged: (value) {
                                          _placeType = value;
                                        },
                                      )),
                                ],
                              )),
                          Visibility(
                              visible: _reminderType == placeReminder,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 8.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .placeHint),
                                        controller: _placeController,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return AppLocalizations.of(context)
                                                .placeMissing;
                                          }

                                          return null;
                                        }),
                                  ),
                                ],
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .radiusLabel(_radius.toInt()),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                            child: Slider(
                              value: _radius,
                              min: 100,
                              max: 2000,
                              divisions: 19,
                              label: _radius.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _radius = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () => _saveReminder(context),
                                    child: Text(AppLocalizations.of(context)
                                        .submit
                                        .toUpperCase()))),
                          )
                        ]))
              ],
            );
          },
        ));
  }
}
