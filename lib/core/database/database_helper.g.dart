// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataBaseModelAdapter extends TypeAdapter<DataBaseModel> {
  @override
  final int typeId = 0;

  @override
  DataBaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataBaseModel(
      id: fields[0] as String,
      firstNum: fields[1] as double,
      secondNum: fields[2] as double,
      operation: fields[3] as Operations,
      status: fields[5] as String,
      result: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataBaseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstNum)
      ..writeByte(2)
      ..write(obj.secondNum)
      ..writeByte(3)
      ..write(obj.operation)
      ..writeByte(4)
      ..write(obj.result)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataBaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
