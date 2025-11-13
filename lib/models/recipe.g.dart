// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      title: fields[1] as String,
      ingredients: (fields[2] as List).cast<String>(),
      steps: (fields[3] as List).cast<String>(),
      photos: (fields[4] as List).cast<String>(),
      category: fields[5] as String,
      tags: (fields[6] as List).cast<String>(),
      prepTime: fields[7] as int,
      cookTime: fields[8] as int,
      servings: fields[9] as int,
      isFavorite: fields[10] as bool,
      dateAdded: fields[11] as DateTime,
      difficulty: fields[12] as String?,
      notes: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.ingredients)
      ..writeByte(3)
      ..write(obj.steps)
      ..writeByte(4)
      ..write(obj.photos)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.prepTime)
      ..writeByte(8)
      ..write(obj.cookTime)
      ..writeByte(9)
      ..write(obj.servings)
      ..writeByte(10)
      ..write(obj.isFavorite)
      ..writeByte(11)
      ..write(obj.dateAdded)
      ..writeByte(12)
      ..write(obj.difficulty)
      ..writeByte(13)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
