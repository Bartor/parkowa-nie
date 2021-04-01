import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ReportsService {
  Database _database;

  Future<void> _init() async {
    if (_database == null) {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, 'my_database.db');
      _database = await databaseFactoryIo.openDatabase(dbPath);
      print("Initialized");
    }
  }

  Future<String> getCoolMesage() async {
    await _init();
    return "Cool message!";
  }
}
