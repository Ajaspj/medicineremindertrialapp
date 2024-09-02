import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final MedicationProvider _medicationProvider;
  List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  HomeViewModel({required MedicationProvider medicationProvider})
      : _medicationProvider = medicationProvider;

  Future<void> loadMedications() async {
    setBusy(true);
    _medications = await _medicationProvider.getMedications();
    setBusy(false);
    notifyListeners(); // Notify listeners after data update
  }

  Future<void> removeMedication(int id) async {
    setBusy(true);
    await _medicationProvider.removeMedication(id);
    await loadMedications(); // Reload medications after removal
    setBusy(false);
  }
}
