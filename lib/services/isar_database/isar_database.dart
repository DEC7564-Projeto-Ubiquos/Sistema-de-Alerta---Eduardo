import 'package:emg_app/models/patient.dart';
import 'package:isar/isar.dart';

abstract class IsarDatabase {
  Future<Isar> openIsar();

  Future<Id> putPatient(Isar isar, Patient patient);

  Future<Patient?> getPatientById(Isar isar, Id id);

  Future<List<Patient>> getAllPatients(Isar isar);
}
