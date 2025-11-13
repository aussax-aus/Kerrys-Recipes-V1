import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recipe.dart';
import '../models/user_settings.dart';

class LocalStorageService {
  static const String recipesBoxName = 'recipes';
  static const String settingsBoxName = 'settings';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RecipeAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserSettingsAdapter());
    }

    // Open boxes
    await Hive.openBox<Recipe>(recipesBoxName);
    await Hive.openBox<UserSettings>(settingsBoxName);
  }

  static Box<Recipe> get recipesBox => Hive.box<Recipe>(recipesBoxName);
  
  static Box<UserSettings> get settingsBox => Hive.box<UserSettings>(settingsBoxName);

  // Recipe operations
  static Future<void> saveRecipe(Recipe recipe) async {
    await recipesBox.put(recipe.id, recipe);
  }

  static Recipe? getRecipe(String id) {
    return recipesBox.get(id);
  }

  static List<Recipe> getAllRecipes() {
    return recipesBox.values.toList();
  }

  static Future<void> deleteRecipe(String id) async {
    await recipesBox.delete(id);
  }

  static Future<void> updateRecipe(Recipe recipe) async {
    await recipesBox.put(recipe.id, recipe);
  }

  // Settings operations
  static UserSettings getSettings() {
    if (settingsBox.isEmpty) {
      final defaultSettings = UserSettings();
      settingsBox.put('user_settings', defaultSettings);
      return defaultSettings;
    }
    return settingsBox.get('user_settings')!;
  }

  static Future<void> saveSettings(UserSettings settings) async {
    await settingsBox.put('user_settings', settings);
  }

  // Backup operations
  static Future<String> exportAllRecipes() async {
    final recipes = getAllRecipes();
    final json = recipes.map((r) => r.toJson()).toList();
    return json.toString();
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
