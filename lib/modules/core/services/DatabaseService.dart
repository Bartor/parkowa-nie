import 'package:flutter/cupertino.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService extends ChangeNotifier {
  Database _db;
  final _userStore = stringMapStoreFactory.store('user');
  final _reportsStore = stringMapStoreFactory.store('reports');

  ContactInformation contact;

  DatabaseService() {
    _init();
  }

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
    if (_db == null) {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, 'db.db');
      _db = await databaseFactoryIo.openDatabase(dbPath);

      _userStore.record('contact').onSnapshot(_db).listen((event) {
        print("Got new data: ${event.value}");
        contact = ContactInformation.fromMap(event.value);
        notifyListeners();
      });
    }
  }

  Future<void> updateContactInformation(
      {ContactInformation information}) async {
    await _init();
    await _userStore.record('contact').put(_db, information.toMap());
  }
}
