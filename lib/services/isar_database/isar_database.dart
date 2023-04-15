import 'package:isar/isar.dart';

abstract class IsarDatabase {
  Future<Isar> openIsar();
}
