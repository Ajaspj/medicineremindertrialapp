// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:medicineremindertrialapp/models/medicationmodel.dart';
// import 'package:medicineremindertrialapp/providers/medication_provider.dart';
// import 'package:stacked/stacked.dart';
// import 'package:timezone/timezone.dart' as tz;

// class AddMedicationViewModel extends BaseViewModel {
//   String? _dosage;
//   String? _instructions;
//   String? _name;
//   DateTime? _time;

//   String? get name => _name;
//   String? get dosage => _dosage;
//   DateTime? get time => _time;
//   String? get instructions => _instructions;

//   void updateName(String value) {
//     _name = value;
//     notifyListeners();
//   }

//   void updateDosage(String value) {
//     _dosage = value;
//     notifyListeners();
//   }

//   void updateTime(DateTime value) {
//     _time = value;
//     notifyListeners();
//   }

//   void updateInstructions(String value) {
//     _instructions = value;
//     notifyListeners();
//   }

//   Future<void> saveMedication(MedicationProvider medicationProvider,
//       FlutterLocalNotificationsPlugin notificationsPlugin) async {
//     try {
//       if (_name != null && _dosage != null && _time != null) {
//         final medication = Medication(
//           name: _name!,
//           dosage: _dosage!,
//           time: _time!,
//           instructions: _instructions ?? '',
//         );

//         // Debugging: Print medication details before adding
//         print('Saving Medication: $medication');

//         await medicationProvider.addMedication(medication);
//         await _scheduleNotification(notificationsPlugin, medication);

//         // Debugging: Confirm medication added and notification scheduled
//         print('Medication added and notification scheduled successfully');
//       } else {
//         // Debugging: Print an error message if any field is missing
//         print('Error: Missing fields in medication details');
//         throw Exception('Missing fields in medication details');
//       }
//     } catch (e) {
//       // Debugging: Print error message
//       print('Error in saveMedication: $e');
//       throw e; // Propagate error
//     }
//   }

//   Future<void> _scheduleNotification(
//       FlutterLocalNotificationsPlugin plugin, Medication medication) async {
//     try {
//       final tz.TZDateTime scheduledDateTime =
//           tz.TZDateTime.from(medication.time, tz.local);

//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'medication_channel',
//         'Medication Reminder',
//         channelDescription: 'Channel for medication reminders',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false,
//       );

//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);

//       await plugin.zonedSchedule(
//         0,
//         'Time to take your medication',
//         '${medication.name} - ${medication.dosage}',
//         scheduledDateTime,
//         platformChannelSpecifics,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//       );

//       // Debugging: Confirm that the notification was scheduled
//       print('Notification scheduled for $scheduledDateTime');
//     } catch (e) {
//       // Debugging: Print error message
//       print('Error in _scheduleNotification: $e');
//       throw e; // Propagate error
//     }
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:timezone/timezone.dart' as tz;

class AddMedicationViewModel extends BaseViewModel {
  String? _dosage;
  String? _instructions;
  String? _name;
  DateTime? _time;

  String? get name => _name;
  String? get dosage => _dosage;
  DateTime? get time => _time;
  String? get instructions => _instructions;

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

  Future<void> saveMedication(MedicationProvider medicationProvider,
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    try {
      if (_name != null && _dosage != null && _time != null) {
        final medication = Medication(
          name: _name!,
          dosage: _dosage!,
          time: _time!,
          instructions: _instructions ?? '',
        );

        print('Saving Medication: $medication');

        await medicationProvider.addMedication(medication);

        // Ensure permission is granted before scheduling notification
        await _requestExactAlarmPermission();

        await _scheduleNotification(notificationsPlugin, medication);

        print('Medication added and notification scheduled successfully');
      } else {
        print('Error: Missing fields in medication details');
        throw Exception('Missing fields in medication details');
      }
    } catch (e) {
      print('Error in saveMedication: $e');
      throw e;
    }
  }

  Future<void> _scheduleNotification(
      FlutterLocalNotificationsPlugin plugin, Medication medication) async {
    try {
      final tz.TZDateTime scheduledDateTime =
          tz.TZDateTime.from(medication.time, tz.local);

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
        0,
        'Time to take your medication',
        '${medication.name} - ${medication.dosage}',
        scheduledDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      print('Notification scheduled for $scheduledDateTime');
    } catch (e) {
      print('Error in _scheduleNotification: $e');
      throw e;
    }
  }

  Future<void> _requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      final status = await Permission.scheduleExactAlarm.request();
      if (status.isDenied) {
        throw Exception('Exact alarm permission denied');
      }
    }
  }
}
