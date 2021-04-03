import 'package:flutter/cupertino.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ReportsService extends ChangeNotifier {
  Database _database;
  List<Report> reports = [
    Report(
        address: 'TestAddress',
        city: 'TestCity',
        dateTime: DateTime.now(),
        offences: [OffenceType.NO_ENOUGH_SIDEWALK_SPACE]),
    Report(
        address: 'TestAddress',
        city: 'TestCity',
        dateTime: DateTime.now().subtract(Duration(days: 2)),
        offences: [
          OffenceType.NO_PARKING_ZONE,
          OffenceType.TOO_CLOSE_TO_CROSSING_INTERSECTION
        ]),
  ];

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
