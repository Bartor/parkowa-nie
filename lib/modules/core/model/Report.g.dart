// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 1;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      address: fields[0] as String,
      city: fields[1] as String,
      dateTime: fields[2] as DateTime,
      offenses: (fields[3] as List)?.cast<String>(),
      licensePlate: fields[4] as String,
      photoUris: (fields[5] as List)?.cast<String>(),
      sent: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.offenses)
      ..writeByte(4)
      ..write(obj.licensePlate)
      ..writeByte(5)
      ..write(obj.photoUris)
      ..writeByte(6)
      ..write(obj.sent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
