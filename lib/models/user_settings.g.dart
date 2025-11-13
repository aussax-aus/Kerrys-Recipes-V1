// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsAdapter extends TypeAdapter<UserSettings> {
  @override
  final int typeId = 1;

  @override
  UserSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettings(
      darkMode: fields[0] as bool,
      cloudSyncEnabled: fields[1] as bool,
      unitSystem: fields[2] as String,
      lastBackup: fields[3] as DateTime?,
      userEmail: fields[4] as String?,
      voiceEnabled: fields[5] as bool,
      defaultView: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.cloudSyncEnabled)
      ..writeByte(2)
      ..write(obj.unitSystem)
      ..writeByte(3)
      ..write(obj.lastBackup)
      ..writeByte(4)
      ..write(obj.userEmail)
      ..writeByte(5)
      ..write(obj.voiceEnabled)
      ..writeByte(6)
      ..write(obj.defaultView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
