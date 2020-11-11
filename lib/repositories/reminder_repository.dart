import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lembrete/models/reminder.dart';

class ReminderRepository {
  ReminderRepository._internal();

  static final ReminderRepository instance = ReminderRepository._internal();
  static final CollectionReference _reminders =
      FirebaseFirestore.instance.collection('reminders');

  static Stream<List<Reminder>> list() {
    final Stream<QuerySnapshot> snapshots = _reminders.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => Reminder.fromMap(snapshot.data(), snapshot.id))
          .toList();

      return result;
    });
  }

  static Future<void> save(Reminder reminder) async {
    if (reminder.id == null) {
      await _reminders.add(reminder.toMap());
    } else {
      await _reminders.doc(reminder.id).update(reminder.toMap());
    }
  }

  static Future<void> delete(String id) async {
    await _reminders.doc(id).delete();
  }
}
