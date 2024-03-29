import 'package:hive/hive.dart';

part 'Offence.g.dart';

@HiveType(typeId: 2)
enum OffenseType {
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
  @HiveField(6)
  TOO_CLOSE_TO_BUS_TRAM_STOP,
  @HiveField(8)
  TOO_HEAVY,
  @HiveField(9)
  AWAY_FROM_THE_EDGE_OF_THE_ROAD,
  @HiveField(10)
  RESIDENCE_ZONE,
  @HiveField(11)
  NO_DRIVING,
  @HiveField(12)
  INCORRECT_PARKING,
  @HiveField(13)
  PARKING_ON_BIKE_LANE
}

final offenses = OffenseType.values.map((e) => e.toString()).toList();
