import 'package:isar/isar.dart';
part 'patient.g.dart';

@Collection()
class Patient {
  Id id = Isar.autoIncrement;
  String nome;
  int idade;

  Patient(
    this.nome,
    this.idade,
  );
}
