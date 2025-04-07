import 'package:irrigazione_iot/src/application/di/service_locator.dart';
import 'package:irrigazione_iot/src/data/datasource/db/db_instance.dart';
import 'package:isar/isar.dart';

abstract class AppAbstractDao {
  final _dbInstance = ServiceLocator.get<LocalDbInstance>();

  Isar? get dbInstance => _dbInstance.isar;
}
