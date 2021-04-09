import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';

class AnalyticsService {
  final analytics = FirebaseAnalytics();

  Future<void> createReport({Report report}) =>
      analytics.logEvent(name: "create_report", parameters: report.toMap());
}
