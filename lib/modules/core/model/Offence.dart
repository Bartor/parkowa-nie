import 'package:hive/hive.dart';

part 'Offence.g.dart';

@HiveType(typeId: 2)
enum OffenceType {
  @HiveField(0)
  NO_PARKING_ZONE,
  @HiveField(1)
  NO_ENOUGH_SIDEWALK_SPACE,
  @HiveField(2)
  TOO_CLOSE_TO_CROSSING,
  @HiveField(3)
  TOO_CLOSE_TO_INTERSECTION,
  @HiveField(4)
  NO_STOPPING_SING,
  @HiveField(5)
  PARKED_ON_GREEN_AREA,
}

final offences = OffenceType.values.map((e) => e.toString()).toList();
