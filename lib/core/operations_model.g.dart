// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationsAdapter extends TypeAdapter<Operations> {
  @override
  final int typeId = 1;

  @override
  Operations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operations(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Operations obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.operation)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
