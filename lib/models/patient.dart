import 'package:isar/isar.dart';
part 'patient.g.dart';

@Collection()
class Patient {
  Id id = Isar.autoIncrement;
  String nome;
  int idade;
  bool habilitado;

  Patient(
    this.nome,
    this.idade,
    this.habilitado,
  );
}
