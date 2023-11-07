import 'package:poetlum/features/realtime_database/data/data_sources/database.dart';
import 'package:poetlum/features/realtime_database/domain/repository/database_manager_interface.dart';

class DatabaseManager implements IDatabaseManager{
  @override
  Future<Map?> read(String path) async {
    final databaseReference = database.ref(path);

    final snapshot = await databaseReference.get();

    return snapshot.exists 
      ? snapshot.value as Map 
      : null;
  }

  @override
  void write(Map data, String path) {
    database.ref(path).set(data);
  }
}
