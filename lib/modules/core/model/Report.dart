import 'package:hive/hive.dart';

part 'Report.g.dart';

@HiveType(typeId: 1)
class Report {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final List<String> offenses;
  @HiveField(4)
  final String licensePlate;
  @HiveField(5)
  final List<String> photoUris;
  @HiveField(6)
  bool sent;

  Report(
      {this.address,
      this.city,
      this.dateTime,
      this.offenses = const [],
      this.licensePlate,
      this.photoUris = const [],
      this.sent = false});
}
