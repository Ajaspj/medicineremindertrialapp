import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicineremindertrialapp/main.dart';
import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:medicineremindertrialapp/viewmodel/EditMedicationViewModel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class EditMedicationScreen extends StatefulWidget {
  final Medication medication;

  EditMedicationScreen({required this.medication});

  @override
  _EditMedicationScreenState createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();

    _timeController = TextEditingController(
      text: DateFormat.Hm().format(widget.medication.time),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditMedicationViewModel>.reactive(
      viewModelBuilder: () => EditMedicationViewModel(
        medication: widget.medication,
        medicationProvider:
            Provider.of<MedicationProvider>(context, listen: false),
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Medication',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: viewModel.name,
                    decoration: InputDecoration(
                      labelText: 'Medication Name',
                      border: OutlineInputBorder(),
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
                    initialValue: viewModel.dosage,
                    decoration: InputDecoration(
                      labelText: 'Dosage',
                      border: OutlineInputBorder(),
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
                    ),
                    readOnly: true,
                    controller: _timeController,
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(viewModel.time),
                      );
                      if (picked != null) {
                        final newTime = DateTime(
                          viewModel.time.year,
                          viewModel.time.month,
                          viewModel.time.day,
                          picked.hour,
                          picked.minute,
                        );
                        viewModel.updateTime(newTime);
                        _timeController.text = DateFormat.Hm().format(newTime);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: viewModel.instructions,
                    decoration: InputDecoration(
                      labelText: 'Instructions',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: viewModel.updateInstructions,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await viewModel
                              .saveChanges(flutterLocalNotificationsPlugin);
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to save changes: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          print('Error: $e');
                        }
                      }
                    },
                    child: Text('Save Changes', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
}
