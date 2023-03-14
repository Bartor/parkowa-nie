// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OffenseTypeAdapter extends TypeAdapter<OffenseType> {
  @override
  final int typeId = 2;

  @override
  OffenseType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return OffenseType.NO_ENOUGH_SIDEWALK_SPACE;
      case 2:
        return OffenseType.TOO_CLOSE_TO_CROSSING;
      case 3:
        return OffenseType.TOO_CLOSE_TO_INTERSECTION;
      case 4:
        return OffenseType.NO_STOPPING_SING;
      case 5:
        return OffenseType.PARKED_ON_GREEN_AREA;
      case 6:
        return OffenseType.TOO_CLOSE_TO_BUS_TRAM_STOP;
      case 8:
        return OffenseType.TOO_HEAVY;
      case 9:
        return OffenseType.AWAY_FROM_THE_EDGE_OF_THE_ROAD;
      case 10:
        return OffenseType.RESIDENCE_ZONE;
      case 11:
        return OffenseType.NO_DRIVING;
      case 12:
        return OffenseType.INCORRECT_PARKING;
      case 13:
        return OffenseType.PARKING_ON_BIKE_LANE;
      default:
        return OffenseType.NO_ENOUGH_SIDEWALK_SPACE;
    }
  }

  @override
  void write(BinaryWriter writer, OffenseType obj) {
    switch (obj) {
      case OffenseType.NO_ENOUGH_SIDEWALK_SPACE:
        writer.writeByte(1);
        break;
      case OffenseType.TOO_CLOSE_TO_CROSSING:
        writer.writeByte(2);
        break;
      case OffenseType.TOO_CLOSE_TO_INTERSECTION:
        writer.writeByte(3);
        break;
      case OffenseType.NO_STOPPING_SING:
        writer.writeByte(4);
        break;
      case OffenseType.PARKED_ON_GREEN_AREA:
        writer.writeByte(5);
        break;
      case OffenseType.TOO_CLOSE_TO_BUS_TRAM_STOP:
        writer.writeByte(6);
        break;
      case OffenseType.TOO_HEAVY:
        writer.writeByte(8);
        break;
      case OffenseType.AWAY_FROM_THE_EDGE_OF_THE_ROAD:
        writer.writeByte(9);
        break;
      case OffenseType.RESIDENCE_ZONE:
        writer.writeByte(10);
        break;
      case OffenseType.NO_DRIVING:
        writer.writeByte(11);
        break;
      case OffenseType.INCORRECT_PARKING:
        writer.writeByte(12);
        break;
      case OffenseType.PARKING_ON_BIKE_LANE:
        writer.writeByte(13);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OffenseTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
