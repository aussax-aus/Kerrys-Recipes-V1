# Features Documentation

## Implemented Features

### 1. Recipe Management

#### Create Recipe
- Add recipe with title, ingredients, and instructions
- Set prep time, cook time, and servings
- Choose category from predefined list
- Add custom tags
- Set difficulty level (Easy, Medium, Hard)
- Add optional notes

#### Edit Recipe
- Modify any recipe field
- Update photos
- Change favorite status
- Update timestamps preserved

#### Delete Recipe
- Confirmation dialog before deletion
- Removes from local storage
- Syncs deletion to cloud (if enabled)

#### View Recipe
- Full recipe details display
- Photo gallery view
- Calculated total time
- Category and tags display
- Favorite indicator

### 2. Search and Filtering

#### Search
- Real-time search as you type
- Searches across:
  - Recipe titles
  - Ingredients
  - Tags
  - Categories

#### Sort Options
- Recently Added (default)
- Alphabetical (A-Z)
- Cooking Time (shortest first)
- Favorites First

#### Filters
- Quick Meals (<30 minutes)
- By Category
- By Tags
- By Difficulty
- Vegetarian filter

### 3. Cooking Mode

#### Step-by-Step Guide
- Large, readable text for each step
- Step counter (Step X of Y)
- Progress bar
- Mark steps as complete
- Navigate forward and backward

#### Built-in Timer
- Set custom timer duration
- Countdown display
- Visual and alert notification when complete
- Multiple timers can be set during cooking

#### Features
- Previous/Next buttons
- Finish cooking confirmation
- Hands-free friendly interface

### 4. User Interface

#### Home Screen
- Welcome message
- Recipe statistics (total, favorites)
- Featured favorite recipes
- Recent recipes list
- Quick navigation
- Empty state for new users

#### Recipe List
- Grid view or List view toggle
- Search bar
- Sort menu
- Filter options
- Pull to refresh
- Empty state

#### Recipe Detail
- Hero image (if available)
- Recipe information cards
- Ingredients checklist
- Numbered instructions
- Action buttons (Edit, Delete, Share)
- Favorite toggle

### 5. Settings

#### Appearance
- Dark Mode toggle
- Light/Dark theme switching
- Default view preference (Grid/List)

#### Measurements
- Unit system selection (Metric/Imperial)

#### Cloud Sync (Optional)
- Enable/Disable sync
- Sign in with Email/Password
- Google Sign-In (if configured)
- Sign out option
- Sync status indicator

#### Backup & Export
- Export recipes as JSON
- Import recipes from JSON
- Last backup timestamp

### 6. Offline-First Architecture

#### Local Storage
- All recipes stored locally with Hive
- Fast, efficient database
- Works 100% offline
- No internet required for basic features

#### Cloud Sync (Optional)
- Background synchronization
- Conflict resolution
- Photo cloud storage
- Settings sync
- Multi-device support

### 7. Photo Management

#### Features
- Add up to 10 photos per recipe
- Photo gallery view
- Local storage for offline access
- Cloud backup (if sync enabled)
- Placeholder images for recipes without photos

#### Storage
- Local file system storage
- Thumbnail generation (planned)
- Firebase Storage integration (optional)

### 8. Design System

#### Warm Kitchen Theme - Light Mode
- Warm Cream background (#FFF8E7)
- Soft Brown primary (#8B7355)
- Muted Red accents (#D4776C)
- Dark Brown text (#4A3C2F)
- Light Wood surfaces (#E5D4C1)

#### Dark Mode
- Dark Slate background (#2A2D3A)
- Amber highlights (#FFB74D)
- Elderberry Purple accents (#9575CD)
- Soft slate cards (#3A3D4A)

#### Typography
- Headers: Merriweather (serif, elegant)
- Subheads: Poppins (sans-serif, modern)
- Body: Open Sans (readable, clean)

#### Components
- Rounded cards (16px radius)
- Elevated shadows
- Material Design 3 components
- Custom recipe cards
- Grid layout system

### 9. Categories

Available categories:
- Breakfast
- Lunch
- Dinner
- Dessert
- Snack
- Appetizer
- Beverage
- Soup
- Salad
- Other

### 10. Tags System

Popular tags:
- Quick
- Healthy
- Vegetarian
- Vegan
- Gluten-Free
- Low-Carb
- High-Protein
- Kid-Friendly
- One-Pot
- Meal-Prep

Custom tags can be added to any recipe.

## Features In Development

### Smart Input Features

#### OCR (Optical Character Recognition)
- Scan handwritten recipes with phone camera
- Extract text from recipe cards
- Auto-populate recipe fields

#### Voice Dictation
- Voice input for ingredients
- Voice input for steps
- Hands-free recipe entry

#### Voice Read-Out
- Text-to-speech for cooking steps
- Voice timer notifications
- Accessibility feature

### Advanced Export

#### PDF Export
- Single recipe as PDF
- Multiple recipes as cookbook PDF
- Custom formatting

#### Recipe Sharing
- Share via email
- Share to social media
- Generate shareable link

#### Batch Operations
- Export entire collection
- Backup with photos
- ZIP archive creation

### Enhanced Photo Features

#### Photo Editor
- Crop and rotate
- Filters and adjustments
- Add annotations

#### Step Photos
- Photo for each cooking step
- Before/after comparisons
- Multiple angles

### Windows-Specific Features

#### Desktop Features
- Window resizing and layouts
- Keyboard shortcuts:
  - Ctrl+N: New recipe
  - Ctrl+F: Search
  - Ctrl+S: Save
  - Ctrl+E: Edit
- Drag and drop images
- File browser integration
- Right-click context menus
- System tray integration

#### File Management
- Import from PDF
- Import from text files
- Browse local photos
- Scheduled backups to Documents folder

### Additional Planned Features

#### Recipe Collections
- Create recipe collections/folders
- Meal planning
- Shopping lists

#### Nutrition Information
- Calorie tracking
- Macro nutrients
- Dietary information

#### Social Features (Optional)
- Share recipes with friends
- Import from shared links
- Recipe ratings and reviews

#### Smart Features
- Recipe suggestions
- Ingredient substitutions
- Scaling calculator (adjust servings)
- Unit conversions

## Platform-Specific Features

### Android
- Material Design widgets
- Android share sheet integration
- Camera integration
- Voice input
- File picker

### iOS
- Cupertino widgets
- iOS share sheet
- Camera integration
- Siri integration (planned)
- iCloud sync alternative (planned)

### Windows
- Native windows controls
- File system integration
- Keyboard shortcuts
- Multi-window support
- Desktop notifications

## API Documentation

### Recipe Model
```dart
Recipe(
  id: String,              // Unique identifier
  title: String,           // Recipe name
  ingredients: List<String>, // List of ingredients
  steps: List<String>,     // Cooking steps
  photos: List<String>,    // Photo URLs/paths
  category: String,        // Recipe category
  tags: List<String>,      // Custom tags
  prepTime: int,          // Minutes
  cookTime: int,          // Minutes
  servings: int,          // Number of servings
  isFavorite: bool,       // Star status
  dateAdded: DateTime,    // Creation timestamp
  difficulty: String?,    // Optional difficulty
  notes: String?,         // Optional notes
)
```

### UserSettings Model
```dart
UserSettings(
  darkMode: bool,              // Theme preference
  cloudSyncEnabled: bool,      // Sync status
  unitSystem: String,          // 'metric' or 'imperial'
  lastBackup: DateTime?,       // Last backup time
  userEmail: String?,          // Cloud user email
  voiceEnabled: bool,          // Voice features
  defaultView: String,         // 'grid' or 'list'
)
```

## Usage Examples

### Creating a Recipe
```dart
final recipe = await recipeService.createRecipe(
  title: 'Chocolate Chip Cookies',
  ingredients: ['2 cups flour', '1 cup sugar', '...'],
  steps: ['Mix ingredients', 'Bake at 350°F', '...'],
  category: 'Dessert',
  tags: ['Quick', 'Kid-Friendly'],
  prepTime: 15,
  cookTime: 12,
  servings: 24,
);
```

### Searching Recipes
```dart
final results = recipeService.searchRecipes('chocolate');
```

### Filtering Recipes
```dart
final quickMeals = recipeService.filterRecipes(
  recipes,
  maxTime: 30,
);
```

### Syncing to Cloud
```dart
await recipeProvider.syncToCloud();
```
