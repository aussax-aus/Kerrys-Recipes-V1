import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../services/firebase_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  String _searchQuery = '';
  String _sortBy = 'date';
  List<String> _selectedCategories = [];
  List<String> _selectedTags = [];
  int? _maxTime;

  List<Recipe> get recipes => _filteredRecipes.isEmpty && _searchQuery.isEmpty 
      ? _recipes 
      : _filteredRecipes;
  
  List<Recipe> get favoriteRecipes => _recipes.where((r) => r.isFavorite).toList();
  
  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;

  Future<void> loadRecipes() async {
    _recipes = _recipeService.getAllRecipes();
    _applyFilters();
    notifyListeners();
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _recipeService.createRecipe(
      title: recipe.title,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
      photos: recipe.photos,
      category: recipe.category,
      tags: recipe.tags,
      prepTime: recipe.prepTime,
      cookTime: recipe.cookTime,
      servings: recipe.servings,
      difficulty: recipe.difficulty,
      notes: recipe.notes,
    );
    await loadRecipes();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipeService.updateRecipe(recipe);
    await loadRecipes();
  }

  Future<void> deleteRecipe(String id) async {
    await _recipeService.deleteRecipe(id);
    await loadRecipes();
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    await _recipeService.toggleFavorite(recipe);
    await loadRecipes();
  }

  void searchRecipes(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _applyFilters();
    notifyListeners();
  }

  void setCategories(List<String> categories) {
    _selectedCategories = categories;
    _applyFilters();
    notifyListeners();
  }

  void setTags(List<String> tags) {
    _selectedTags = tags;
    _applyFilters();
    notifyListeners();
  }

  void setMaxTime(int? maxTime) {
    _maxTime = maxTime;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategories = [];
    _selectedTags = [];
    _maxTime = null;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    var filtered = _recipes;

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = _recipeService.searchRecipes(_searchQuery);
    }

    // Apply filters
    filtered = _recipeService.filterRecipes(
      filtered,
      categories: _selectedCategories.isEmpty ? null : _selectedCategories,
      tags: _selectedTags.isEmpty ? null : _selectedTags,
      maxTime: _maxTime,
    );

    // Apply sort
    filtered = _recipeService.sortRecipes(filtered, _sortBy);

    _filteredRecipes = filtered;
  }

  // Cloud sync
  Future<void> syncToCloud() async {
    if (FirebaseService.isSignedIn) {
      await FirebaseService.syncAllRecipes(_recipes);
    }
  }

  Future<void> syncFromCloud() async {
    if (FirebaseService.isSignedIn) {
      final cloudRecipes = await FirebaseService.fetchAllRecipes();
      // Merge logic here - for now, just replace
      for (final recipe in cloudRecipes) {
        await _recipeService.updateRecipe(recipe);
      }
      await loadRecipes();
    }
  }
}
