import 'package:emg_app/screens/select_patient.dart';
import 'package:emg_app/services/isar_database/isar_database.dart';
import 'package:emg_app/services/isar_database/isar_database_prod.dart';
import 'package:flutter/material.dart';
import 'package:emg_app/models/patient.dart';
import 'package:isar/isar.dart';

class PatientProvider extends ChangeNotifier {
  Patient? _selectedPatient;
  bool _showingDialog = false;
  late Isar _isar;
  final IsarDatabase _db = IsarDatabaseProd();

  PatientProvider() {
    _selectedPatient = null;
  }

  Patient? get selectedPatient => _selectedPatient;

  IsarDatabase get db => _db;

  Future<Id> putPatient(Patient patient) async {
    Id id = await _db.putPatient(_isar, patient);
    notifyListeners();
    return id;
  }

  Future<Patient> getPatient(BuildContext context, Id id) async {
    return await _db.getPatientById(_isar, id).then((patient) {
      if (patient == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Paciente não encontrado. Por favor, tente novamente.'),
            duration: Duration(seconds: 5),
          ),
        );
        throw Exception('Paciente não encontrado. Por favor, tente novamente.');
      }
      return patient;
    });
  }

  Future<List<Patient>> getAllPatients() async {
    return await _db.getAllPatients(_isar);
  }

  void selectPatient(Patient patient) {
    _selectedPatient = patient;
    notifyListeners();
  }

  void clearSelectedPatient() {
    _selectedPatient = null;
    notifyListeners();
  }

  void checkForSelectedPatient(BuildContext context) {
    if (_selectedPatient == null && !_showingDialog) {
      _showingDialog = true;
      _showPatientSelectionModal(context);
    }
  }

  void _showPatientSelectionModal(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => const SelectPatient(),
        fullscreenDialog: true,
      ),
    )
        .then((_) {
      _showingDialog = false;
      if (selectedPatient == null) {
        checkForSelectedPatient(context);
      }
    });
  }

  Future<void> init() async {
    _isar = await _db.openIsar();
    notifyListeners();
  }
}
