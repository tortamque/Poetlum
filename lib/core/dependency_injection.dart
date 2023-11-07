import 'package:get_it/get_it.dart';
import 'package:poetlum/features/realtime_database/domain/entities/database_manager.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  getIt.registerSingleton<DatabaseManager>(DatabaseManager());
}
