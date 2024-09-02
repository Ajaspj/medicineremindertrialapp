import 'package:flutter/material.dart';
import 'package:medicineremindertrialapp/database/database_helper.dart';
import 'package:medicineremindertrialapp/models/medicationmodel.dart';

class MedicationProvider with ChangeNotifier {
  List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  MedicationProvider() {
    loadMedications();
  }

  Future<void> addMedication(Medication medication) async {
    await DatabaseHelper().insertMedication(medication);
    await loadMedications();
  }

  Future<void> updateMedication(Medication medication) async {
    await DatabaseHelper().updateMedication(medication);
    await loadMedications();
  }

  Future<void> removeMedication(int id) async {
    await DatabaseHelper().deleteMedication(id);
    await loadMedications(); // Reload medications after removal
  }

  Future<List<Medication>> getMedications() async {
    return await DatabaseHelper().getMedications();
  }

  Future<void> loadMedications() async {
    _medications = await getMedications();
    notifyListeners(); // Notify listeners to update UI
  }
}
