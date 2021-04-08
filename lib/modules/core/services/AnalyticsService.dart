import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';

class AnalyticsService {
  final analytics = FirebaseAnalytics();

  Future<void> createReport({Report report}) =>
      analytics.logEvent(name: "create_report", parameters: report.toMap());
}
