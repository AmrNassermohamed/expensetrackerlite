// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      hiveId: fields[0] as String,
      hiveTitle: fields[1] as String,
      hiveAmount: fields[2] as double,
      hiveDate: fields[3] as DateTime,
      hiveCategory: fields[4] as String,
      hiveConvertedAmountUSD: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveTitle)
      ..writeByte(2)
      ..write(obj.hiveAmount)
      ..writeByte(3)
      ..write(obj.hiveDate)
      ..writeByte(4)
      ..write(obj.hiveCategory)
      ..writeByte(5)
      ..write(obj.hiveConvertedAmountUSD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
