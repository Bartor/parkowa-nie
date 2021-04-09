// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OffenceTypeAdapter extends TypeAdapter<OffenceType> {
  @override
  final int typeId = 2;

  @override
  OffenceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return OffenceType.NO_ENOUGH_SIDEWALK_SPACE;
      case 2:
        return OffenceType.TOO_CLOSE_TO_CROSSING;
      case 3:
        return OffenceType.TOO_CLOSE_TO_INTERSECTION;
      case 4:
        return OffenceType.NO_STOPPING_SING;
      case 5:
        return OffenceType.PARKED_ON_GREEN_AREA;
      case 6:
        return OffenceType.TOO_CLOSE_TO_BUS_TRAM_STOP;
      case 7:
        return OffenceType.OBSTRUCTING_LEGALLY_PARKED_VEHICLE;
      case 8:
        return OffenceType.TOO_HEAVY;
      case 9:
        return OffenceType.AWAY_FROM_THE_EDGE_OF_THE_ROAD;
      case 10:
        return OffenceType.RESIDENCE_ZONE;
      default:
        return OffenceType.NO_ENOUGH_SIDEWALK_SPACE;
    }
  }

  @override
  void write(BinaryWriter writer, OffenceType obj) {
    switch (obj) {
      case OffenceType.NO_ENOUGH_SIDEWALK_SPACE:
        writer.writeByte(1);
        break;
      case OffenceType.TOO_CLOSE_TO_CROSSING:
        writer.writeByte(2);
        break;
      case OffenceType.TOO_CLOSE_TO_INTERSECTION:
        writer.writeByte(3);
        break;
      case OffenceType.NO_STOPPING_SING:
        writer.writeByte(4);
        break;
      case OffenceType.PARKED_ON_GREEN_AREA:
        writer.writeByte(5);
        break;
      case OffenceType.TOO_CLOSE_TO_BUS_TRAM_STOP:
        writer.writeByte(6);
        break;
      case OffenceType.OBSTRUCTING_LEGALLY_PARKED_VEHICLE:
        writer.writeByte(7);
        break;
      case OffenceType.TOO_HEAVY:
        writer.writeByte(8);
        break;
      case OffenceType.AWAY_FROM_THE_EDGE_OF_THE_ROAD:
        writer.writeByte(9);
        break;
      case OffenceType.RESIDENCE_ZONE:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OffenceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
