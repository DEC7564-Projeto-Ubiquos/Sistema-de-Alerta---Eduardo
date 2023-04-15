import 'package:emg_app/services/isar_database/isar_database.dart';
import 'package:isar/isar.dart';

class IsarDatabaseProd extends IsarDatabase {
  // Abre uma instãncia da base para fazer operações CRUD
  @override
  Future<Isar> openIsar() async {
    final isar = await Isar.open(
      [],
      inspector: true,
    );

    return isar;
  }
}
