import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:timezone/timezone.dart' as tz;

class EditMedicationViewModel extends BaseViewModel {
  late String _name;
  late String _dosage;
  late DateTime _time;
  late String _instructions;

  final Medication medication;
  final MedicationProvider medicationProvider;

  EditMedicationViewModel({
    required this.medication,
    required this.medicationProvider,
  }) {
    _name = medication.name;
    _dosage = medication.dosage;
    _time = medication.time;
    _instructions = medication.instructions;
  }

  String get name => _name;
  String get dosage => _dosage;
  DateTime get time => _time;
  String get instructions => _instructions;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateDosage(String value) {
    _dosage = value;
    notifyListeners();
  }

  void updateTime(DateTime value) {
    _time = value;
    notifyListeners();
  }

  void updateInstructions(String value) {
    _instructions = value;
    notifyListeners();
  }

  Future<void> saveChanges(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    final updatedMedication = Medication(
      id: medication.id,
      name: _name,
      dosage: _dosage,
      time: _time,
      instructions: _instructions,
    );
    medicationProvider.updateMedication(updatedMedication);
    await _scheduleNotification(notificationsPlugin, updatedMedication);
  }

  Future<void> _scheduleNotification(
      FlutterLocalNotificationsPlugin plugin, Medication medication) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'medication_channel',
      'Medication Reminder',
      channelDescription: 'Channel for medication reminders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await plugin.zonedSchedule(
      medication.id!,
      'Time to take your medication',
      '${medication.name} - ${medication.dosage}',
      tz.TZDateTime.from(medication.time, tz.local),
      platformChannelSpecifics,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
