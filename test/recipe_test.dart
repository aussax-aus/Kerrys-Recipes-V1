import 'package:flutter_test/flutter_test.dart';
import 'package:kerrys_recipes/models/recipe.dart';

void main() {
  group('Recipe Model Tests', () {
    test('Recipe creation', () {
      final recipe = Recipe(
        id: 'test-id',
        title: 'Test Recipe',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        steps: ['Step 1', 'Step 2'],
        photos: [],
        category: 'Dinner',
        tags: ['Quick', 'Easy'],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        isFavorite: false,
        dateAdded: DateTime.now(),
      );

      expect(recipe.title, 'Test Recipe');
      expect(recipe.ingredients.length, 2);
      expect(recipe.steps.length, 2);
      expect(recipe.totalTime, 30);
    });

    test('Recipe totalTime calculation', () {
      final recipe = Recipe(
        id: 'test-id',
        title: 'Test Recipe',
        ingredients: [],
        steps: [],
        photos: [],
        category: 'Dinner',
        tags: [],
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        isFavorite: false,
        dateAdded: DateTime.now(),
      );

      expect(recipe.totalTime, 40);
    });

    test('Recipe JSON serialization', () {
      final now = DateTime.now();
      final recipe = Recipe(
        id: 'test-id',
        title: 'Test Recipe',
        ingredients: ['Ingredient 1'],
        steps: ['Step 1'],
        photos: ['photo1.jpg'],
        category: 'Dinner',
        tags: ['Quick'],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        isFavorite: true,
        dateAdded: now,
      );

      final json = recipe.toJson();
      expect(json['title'], 'Test Recipe');
      expect(json['prepTime'], 10);
      expect(json['isFavorite'], true);

      final recreatedRecipe = Recipe.fromJson(json);
      expect(recreatedRecipe.title, recipe.title);
      expect(recreatedRecipe.prepTime, recipe.prepTime);
      expect(recreatedRecipe.isFavorite, recipe.isFavorite);
    });

    test('Recipe copyWith', () {
      final recipe = Recipe(
        id: 'test-id',
        title: 'Original Title',
        ingredients: [],
        steps: [],
        photos: [],
        category: 'Dinner',
        tags: [],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        isFavorite: false,
        dateAdded: DateTime.now(),
      );

      final updated = recipe.copyWith(
        title: 'Updated Title',
        isFavorite: true,
      );

      expect(updated.title, 'Updated Title');
      expect(updated.isFavorite, true);
      expect(updated.prepTime, 10); // Unchanged
      expect(updated.id, recipe.id); // Unchanged
    });
  });
}
