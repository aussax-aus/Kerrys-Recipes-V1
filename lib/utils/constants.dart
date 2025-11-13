class Constants {
  // App Info
  static const String appName = 'My Kitchen Book';
  static const String appVersion = '1.0.0';
  
  // Categories
  static const List<String> categories = [
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

  // Difficulty Levels
  static const List<String> difficultyLevels = [
    'Easy',
    'Medium',
    'Hard',
  ];

  // Popular Tags
  static const List<String> popularTags = [
    'Quick',
    'Healthy',
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Low-Carb',
    'High-Protein',
    'Kid-Friendly',
    'One-Pot',
    'Meal-Prep',
  ];

  // Time Filters
  static const int quickMealMaxTime = 30; // minutes
  static const int mediumMealMaxTime = 60; // minutes

  // Photo Limits
  static const int maxPhotosPerRecipe = 10;
  static const int photoQuality = 85; // JPEG quality 0-100

  // Database
  static const String recipesBoxName = 'recipes';
  static const String settingsBoxName = 'settings';

  // Sync
  static const int syncIntervalMinutes = 5;
  static const int backupReminderDays = 7;
}
