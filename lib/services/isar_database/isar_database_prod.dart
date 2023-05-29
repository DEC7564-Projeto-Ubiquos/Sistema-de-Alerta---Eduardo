import 'package:emg_app/models/patient.dart';
import 'package:emg_app/services/isar_database/isar_database.dart';
import 'package:isar/isar.dart';

class IsarDatabaseProd extends IsarDatabase {
  // Abre uma instãncia da base para fazer operações CRUD
  @override
  Future<Isar> openIsar() async {
    final isar;
    if (Isar.instanceNames.isEmpty) {
      isar = await Isar.open(
        [PatientSchema],
        inspector: true,
      );
    } else {
      isar = Isar.getInstance(Isar.instanceNames.first);
    }

    return isar;
  }

  @override
  Future<Id> putPatient(Isar isar, Patient patient) async {
    Id id = await isar.writeTxn(() async {
      return await isar.patients.put(patient);
    });
    return id;
  }

  @override
  Future<Patient?> getPatientById(Isar isar, Id id) async {
    final Patient? patient = await isar.patients.get(id);

    return patient;
  }

  @override
  Future<List<Patient>> getAllPatients(Isar isar) async {
    final patients = await isar.patients.where().findAll();
    return patients;
  }
}
