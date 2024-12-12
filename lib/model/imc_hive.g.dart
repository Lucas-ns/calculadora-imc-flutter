// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcHiveAdapter extends TypeAdapter<ImcHive> {
  @override
  final int typeId = 1;

  @override
  ImcHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImcHive(
      nome: fields[0] as String,
      peso: fields[1] as double,
      altura: fields[2] as double,
      imc: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ImcHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.peso)
      ..writeByte(2)
      ..write(obj.altura)
      ..writeByte(3)
      ..write(obj.imc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
