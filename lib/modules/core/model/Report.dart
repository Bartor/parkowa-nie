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
  final List<String> offences;
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
      this.offences = const [],
      this.licensePlate,
      this.photoUris = const [],
      this.sent = false});

  Map<String, dynamic> toMap() => {
        "city": city,
        "offences_number": offences.length,
        "license_plate": licensePlate
      };
}
