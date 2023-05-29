import 'package:isar/isar.dart';
part 'patient.g.dart';

@Collection()
class Patient {
  Id id;
  String identificador;
  int idade;

  Patient(
    this.identificador,
    this.idade, {
    Id? id,
  }) : id = id ?? Isar.autoIncrement;
}
