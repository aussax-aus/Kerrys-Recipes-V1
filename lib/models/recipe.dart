import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late List<String> ingredients;

  @HiveField(3)
  late List<String> steps;

  @HiveField(4)
  late List<String> photos;

  @HiveField(5)
  late String category;

  @HiveField(6)
  late List<String> tags;

  @HiveField(7)
  late int prepTime;

  @HiveField(8)
  late int cookTime;

  @HiveField(9)
  late int servings;

  @HiveField(10)
  late bool isFavorite;

  @HiveField(11)
  late DateTime dateAdded;

  @HiveField(12)
  String? difficulty;

  @HiveField(13)
  String? notes;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.photos,
    required this.category,
    required this.tags,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.isFavorite,
    required this.dateAdded,
    this.difficulty,
    this.notes,
  });

  int get totalTime => prepTime + cookTime;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'ingredients': ingredients,
        'steps': steps,
        'photos': photos,
        'category': category,
        'tags': tags,
        'prepTime': prepTime,
        'cookTime': cookTime,
        'servings': servings,
        'isFavorite': isFavorite,
        'dateAdded': dateAdded.toIso8601String(),
        'difficulty': difficulty,
        'notes': notes,
      };

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as String,
        title: json['title'] as String,
        ingredients: List<String>.from(json['ingredients'] as List),
        steps: List<String>.from(json['steps'] as List),
        photos: List<String>.from(json['photos'] as List),
        category: json['category'] as String,
        tags: List<String>.from(json['tags'] as List),
        prepTime: json['prepTime'] as int,
        cookTime: json['cookTime'] as int,
        servings: json['servings'] as int,
        isFavorite: json['isFavorite'] as bool,
        dateAdded: DateTime.parse(json['dateAdded'] as String),
        difficulty: json['difficulty'] as String?,
        notes: json['notes'] as String?,
      );

  Recipe copyWith({
    String? id,
    String? title,
    List<String>? ingredients,
    List<String>? steps,
    List<String>? photos,
    String? category,
    List<String>? tags,
    int? prepTime,
    int? cookTime,
    int? servings,
    bool? isFavorite,
    DateTime? dateAdded,
    String? difficulty,
    String? notes,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      ingredients: ingredients ?? List<String>.from(this.ingredients),
      steps: steps ?? List<String>.from(this.steps),
      photos: photos ?? List<String>.from(this.photos),
      category: category ?? this.category,
      tags: tags ?? List<String>.from(this.tags),
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
      isFavorite: isFavorite ?? this.isFavorite,
      dateAdded: dateAdded ?? this.dateAdded,
      difficulty: difficulty ?? this.difficulty,
      notes: notes ?? this.notes,
    );
  }
}
