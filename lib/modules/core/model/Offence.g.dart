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
      case 0:
        return OffenceType.NO_PARKING_ZONE;
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
      default:
        return OffenceType.NO_PARKING_ZONE;
    }
  }

  @override
  void write(BinaryWriter writer, OffenceType obj) {
    switch (obj) {
      case OffenceType.NO_PARKING_ZONE:
        writer.writeByte(0);
        break;
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
