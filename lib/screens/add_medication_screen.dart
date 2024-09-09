// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicineremindertrialapp/main.dart';
// import 'package:medicineremindertrialapp/providers/medication_provider.dart';
// import 'package:medicineremindertrialapp/screens/home_screen.dart';
// import 'package:medicineremindertrialapp/viewmodel/AddMedicationViewModel.dart';
// import 'package:provider/provider.dart';
// import 'package:stacked/stacked.dart';

// class AddMedicationScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AddMedicationViewModel>.reactive(
//       viewModelBuilder: () => AddMedicationViewModel(),
//       builder: (context, viewModel, child) {
//         final timeController = TextEditingController(
//           text: viewModel.time == null
//               ? ''
//               : DateFormat.Hm().format(viewModel.time!),
//         );

//         final medicationProvider =
//             Provider.of<MedicationProvider>(context, listen: false);
//         final notificationsPlugin = flutterLocalNotificationsPlugin;

//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Add Medication',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//                 letterSpacing: 1.2,
//               ),
//             ),
//             backgroundColor: Colors.white,
//           ),
//           body: SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Enter Medication Details',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Medication Name',
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.indigo),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter medication name';
//                       }
//                       return null;
//                     },
//                     onChanged: viewModel.updateName,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Dosage',
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.indigo),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter dosage';
//                       }
//                       return null;
//                     },
//                     onChanged: viewModel.updateDosage,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Time',
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.indigo),
//                       ),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       TimeOfDay? picked = await showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay.now(),
//                       );
//                       if (picked != null) {
//                         final pickedTime = DateTime(
//                           DateTime.now().year,
//                           DateTime.now().month,
//                           DateTime.now().day,
//                           picked.hour,
//                           picked.minute,
//                         );
//                         viewModel.updateTime(pickedTime);
//                         timeController.text =
//                             DateFormat.Hm().format(pickedTime);
//                       }
//                     },
//                     validator: (value) {
//                       if (viewModel.time == null) {
//                         return 'Please pick a time';
//                       }
//                       return null;
//                     },
//                     controller: timeController,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Instructions',
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.indigo),
//                       ),
//                     ),
//                     onChanged: viewModel.updateInstructions,
//                   ),
//                   SizedBox(height: 32),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           try {
//                             await viewModel.saveMedication(
//                               medicationProvider,
//                               notificationsPlugin,
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Medication added successfully!'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );

//                             _formKey.currentState!.reset();
//                             timeController.clear();
//                             viewModel.updateName('');
//                             viewModel.updateDosage('');
//                             viewModel.updateInstructions('');

//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                   builder: (context) => HomeScreen()),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Failed to add medication: $e'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );

//                             print('Error: $e');
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.indigo,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 5,
//                         shadowColor: Colors.black.withOpacity(0.2),
//                         side: BorderSide(
//                           color: Colors.indigo.shade800,
//                           width: 2,
//                         ),
//                       ).copyWith(
//                         backgroundColor:
//                             MaterialStateProperty.resolveWith<Color?>(
//                           (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return Colors.indigo.withOpacity(0.7);
//                             }
//                             return Colors.indigo;
//                           },
//                         ),
//                       ),
//                       child: Text(
//                         'Add Medication',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:medicineremindertrialapp/main.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:medicineremindertrialapp/screens/home_screen.dart';
import 'package:medicineremindertrialapp/viewmodel/AddMedicationViewModel.dart';

class AddMedicationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMedicationViewModel>.reactive(
      viewModelBuilder: () => AddMedicationViewModel(),
      builder: (context, viewModel, child) {
        final timeController = TextEditingController(
          text: viewModel.time == null
              ? ''
              : DateFormat.Hm().format(viewModel.time!),
        );

        final medicationProvider =
            Provider.of<MedicationProvider>(context, listen: false);
        final notificationsPlugin = flutterLocalNotificationsPlugin;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Medication',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Medication Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medication Name',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter medication name';
                      }
                      return null;
                    },
                    onChanged: viewModel.updateName,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dosage',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter dosage';
                      }
                      return null;
                    },
                    onChanged: viewModel.updateDosage,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final pickedTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                          picked.minute,
                        );
                        viewModel.updateTime(pickedTime);
                        timeController.text =
                            DateFormat.Hm().format(pickedTime);
                      }
                    },
                    validator: (value) {
                      if (viewModel.time == null) {
                        return 'Please pick a time';
                      }
                      return null;
                    },
                    controller: timeController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Instructions',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                    onChanged: viewModel.updateInstructions,
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await viewModel.saveMedication(
                              medicationProvider,
                              notificationsPlugin,
                            );

                            // Schedule notification for the selected time
                            _scheduleNotification(
                              notificationsPlugin,
                              viewModel.time!,
                              viewModel.name!,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Medication added successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            _formKey.currentState!.reset();
                            timeController.clear();
                            viewModel.updateName('');
                            viewModel.updateDosage('');
                            viewModel.updateInstructions('');

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to add medication: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );

                            print('Error: $e');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.2),
                        side: BorderSide(
                          color: Colors.indigo.shade800,
                          width: 2,
                        ),
                      ).copyWith(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.indigo.withOpacity(0.7);
                            }
                            return Colors.indigo;
                          },
                        ),
                      ),
                      child: Text(
                        'Add Medication',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _scheduleNotification(
    FlutterLocalNotificationsPlugin notificationsPlugin,
    DateTime scheduledTime,
    String medicationName,
  ) {
    // Initialize timezone
    tz.initializeTimeZones();

    notificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Time to take your medication!',
      'It\'s time to take your $medicationName.',
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_channel_id',
          'Medication Reminders',

          importance: Importance.max, // Show in status bar with sound
          priority: Priority.high, // High priority to trigger sound
          playSound: true, // Play a sound
          sound: RawResourceAndroidNotificationSound(
              'alarm_sound'), // Custom sound
          enableLights: true, // Enable LED indicator on supported devices
          enableVibration: true, // Enable vibration
          ledColor: Colors.red, // LED color if supported
          ledOnMs: 1000, // LED on duration
          ledOffMs: 500, // LED off duration
          showWhen: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
