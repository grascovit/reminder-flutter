import 'package:flutter/material.dart';
import 'package:lembrete/models/reminder.dart';

class ReminderForm extends StatefulWidget {
  static String routeName = '/reminder_form';

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  double _radius = 100;
  String _reminderType;
  String _placeType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  static const String PLACE_REMINDER = 'PLACE_REMINDER';
  static const String PLACE_TYPE_REMINDER = 'PLACE_TYPE_REMINDER';

  void _saveReminder(context) {
    if (_formKey.currentState.validate()) {
      final reminder = Reminder(
          description: _descriptionController.text,
          place: _placeController.text,
          placeType: _placeType,
          radius: _radius);
      Navigator.pop(context, reminder);
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
    final Map arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text(arguments['title'])),
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
                              'Remind me to:',
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
                                    hintText: 'Description',
                                    border: OutlineInputBorder(),
                                    helperText:
                                        'An action you should remind of: buy milk, feed your pet, etc.'),
                                controller: _descriptionController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter a description';
                                  }

                                  return null;
                                }),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                            child: Text(
                              'When I am:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          RadioListTile(
                            title: const Text('Near a specific place'),
                            value: PLACE_REMINDER,
                            groupValue: _reminderType,
                            onChanged: (value) {
                              setState(() {
                                _reminderType = value;
                                _placeType = null;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                                'Near places with a specific category'),
                            value: PLACE_TYPE_REMINDER,
                            groupValue: _reminderType,
                            onChanged: (value) {
                              setState(() {
                                _reminderType = value;
                                _placeController.value = TextEditingValue.empty;
                              });
                            },
                          ),
                          Visibility(
                              visible: _reminderType == PLACE_TYPE_REMINDER,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 8.0),
                                    child: Text(
                                      'And I am near a place of the following type:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please enter a place type';
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                        hint: Text('Place Type'),
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
                              visible: _reminderType == PLACE_REMINDER,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 8.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Place'),
                                        controller: _placeController,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return 'Please enter a place';
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
                              'And I am at most ${_radius.toInt()} meters away from it',
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
                                    child: Text('Submit'.toUpperCase()))),
                          )
                        ]))
              ],
            );
          },
        ));
  }
}
