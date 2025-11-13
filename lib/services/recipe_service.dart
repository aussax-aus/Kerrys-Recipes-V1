import 'package:uuid/uuid.dart';
import '../models/recipe.dart';
import 'local_storage_service.dart';

class RecipeService {
  static const _uuid = Uuid();

  // Create
  Future<Recipe> createRecipe({
    required String title,
    required List<String> ingredients,
    required List<String> steps,
    List<String> photos = const [],
    String category = 'Other',
    List<String> tags = const [],
    int prepTime = 0,
    int cookTime = 0,
    int servings = 1,
    String? difficulty,
    String? notes,
  }) async {
    final recipe = Recipe(
      id: _uuid.v4(),
      title: title,
      ingredients: ingredients,
      steps: steps,
      photos: photos,
      category: category,
      tags: tags,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      isFavorite: false,
      dateAdded: DateTime.now(),
      difficulty: difficulty,
      notes: notes,
    );

    await LocalStorageService.saveRecipe(recipe);
    return recipe;
  }

  // Read
  Recipe? getRecipe(String id) {
    return LocalStorageService.getRecipe(id);
  }

  List<Recipe> getAllRecipes() {
    return LocalStorageService.getAllRecipes();
  }

  List<Recipe> getFavoriteRecipes() {
    return getAllRecipes().where((r) => r.isFavorite).toList();
  }

  List<Recipe> getRecipesByCategory(String category) {
    return getAllRecipes().where((r) => r.category == category).toList();
  }

  List<Recipe> searchRecipes(String query) {
    final lowercaseQuery = query.toLowerCase();
    return getAllRecipes().where((recipe) {
      return recipe.title.toLowerCase().contains(lowercaseQuery) ||
          recipe.ingredients.any((i) => i.toLowerCase().contains(lowercaseQuery)) ||
          recipe.tags.any((t) => t.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  // Update
  Future<void> updateRecipe(Recipe recipe) async {
    await LocalStorageService.updateRecipe(recipe);
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    final updated = recipe.copyWith(isFavorite: !recipe.isFavorite);
    await updateRecipe(updated);
  }

  // Delete
  Future<void> deleteRecipe(String id) async {
    await LocalStorageService.deleteRecipe(id);
  }

  // Sort and filter
  List<Recipe> sortRecipes(List<Recipe> recipes, String sortBy) {
    final sorted = List<Recipe>.from(recipes);
    switch (sortBy) {
      case 'alphabetical':
        sorted.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'date':
        sorted.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
        break;
      case 'time':
        sorted.sort((a, b) => a.totalTime.compareTo(b.totalTime));
        break;
      case 'favorites':
        sorted.sort((a, b) {
          if (a.isFavorite == b.isFavorite) return 0;
          return a.isFavorite ? -1 : 1;
        });
        break;
    }
    return sorted;
  }

  List<Recipe> filterRecipes(List<Recipe> recipes, {
    List<String>? categories,
    List<String>? tags,
    int? maxTime,
  }) {
    var filtered = recipes;

    if (categories != null && categories.isNotEmpty) {
      filtered = filtered.where((r) => categories.contains(r.category)).toList();
    }

    if (tags != null && tags.isNotEmpty) {
      filtered = filtered.where((r) => 
        r.tags.any((tag) => tags.contains(tag))
      ).toList();
    }

    if (maxTime != null) {
      filtered = filtered.where((r) => r.totalTime <= maxTime).toList();
    }

    return filtered;
  }

  // Categories
  List<String> getCategories() {
    return [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Dessert',
      'Snack',
      'Appetizer',
      'Beverage',
      'Soup',
      'Salad',
      'Other',
    ];
  }
}
