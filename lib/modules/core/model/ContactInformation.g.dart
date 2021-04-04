// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactInformation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactInformationAdapter extends TypeAdapter<ContactInformation> {
  @override
  final int typeId = 0;

  @override
  ContactInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactInformation(
      address: fields[0] as String,
      fullName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactInformation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
