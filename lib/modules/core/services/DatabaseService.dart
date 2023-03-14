import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/model/AppData.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService extends ChangeNotifier {
  Box _userBox;
  Box _reportsBox;
  bool _initialized = false;

  ContactInformation contact;
  AppData appData;
  Map<dynamic, Report> reports = {};

  DatabaseService() {
    _init();
  }

  Future<void> _init() async {
    if (_initialized == false) {
      _userBox = await Hive.openBox('user');
      _reportsBox = await Hive.openBox<Report>('reports');
      _initialized = true;

      _userBox.listenable().addListener(() async {
        contact = await _userBox.get('contact_information');
        appData = await _userBox.get('app_data');
        notifyListeners();
      });

      _reportsBox.listenable().addListener(() async {
        reports = _reportsBox.toMap();
        notifyListeners();
      });

      contact = await _userBox.get('contact_information');
      appData = await _userBox.get('app_data');
      reports = _reportsBox.toMap();
      notifyListeners();
    }
  }

  Future<int> addReport({Report report}) async {
    await _init();
    return await _reportsBox.add(report);
  }

  Future<void> updateReport({Report report, int id}) async {
    await _init();
    await _reportsBox.put(id, report);
  }

  Future<void> deleteReport({int reportId}) async {
    await _init();
    await _reportsBox.delete(reportId);
  }

  Future<void> updateContactInformation(
      {ContactInformation information}) async {
    await _init();
    await _userBox.put('contact_information', information);
  }

  Future<void> updateAppData({AppData appData}) async {
    await _init();
    await _userBox.put('app_data', appData);
  }
}
