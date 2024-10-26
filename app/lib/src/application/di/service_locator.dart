import 'package:get_it/get_it.dart';
import 'package:irrigazione_iot/src/data/datasource/db/db_instance.dart';

class ServiceLocator {
  static GetIt get _getIt {
    return GetIt.instance;
  }

  static Future<void> init() async {
    // register repos
    _registerRepositories();

    await _initDb();
  }

  static Future<void> _initDb() async {
    final dbInstance = ServiceLocator.get<LocalDbInstance>();
    await dbInstance.initLocalDb();
  }

  static void _registerRepositories() {
    final getIt = _getIt;

    getIt.registerSingleton<LocalDbInstance>(LocalDbInstance());
  }

  // Used to access items
  static T get<T extends Object>() {
    switch (T) {
      case LocalDbInstance:
        return _getIt.get<LocalDbInstance>() as T;
      default:
    }

    return _getIt.get<T>();
  }
}
