# Architecture Documentation

## Overview

My Kitchen Book is built using Flutter with a clean, layered architecture that supports offline-first operation with optional cloud synchronization.

## Architecture Layers

```
┌─────────────────────────────────────────────┐
│            Presentation Layer                │
│   (UI Screens, Widgets, Theme)              │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│         State Management Layer               │
│   (Providers - Recipe, Settings)            │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│          Business Logic Layer                │
│   (Services - Recipe, Storage, Firebase)    │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│            Data Layer                        │
│   (Models, Hive Database, Firebase)         │
└─────────────────────────────────────────────┘
```

## Layer Details

### 1. Presentation Layer

**Components:**
- Screens: Full-page UI components
- Widgets: Reusable UI components
- Theme: Design system and styling

**Responsibilities:**
- Display data to user
- Handle user interactions
- Navigation between screens
- Apply theming

**Key Files:**
- `lib/screens/` - All screen implementations
- `lib/widgets/` - Reusable components
- `lib/utils/theme.dart` - Theme configuration

### 2. State Management Layer

**Technology:** Provider pattern

**Components:**
- RecipeProvider: Manages recipe state
- SettingsProvider: Manages app settings state

**Responsibilities:**
- Hold application state
- Notify UI of state changes
- Coordinate between services and UI
- Handle business logic flow

**Key Files:**
- `lib/providers/recipe_provider.dart`
- `lib/providers/settings_provider.dart`

### 3. Business Logic Layer

**Components:**
- RecipeService: Recipe CRUD operations
- LocalStorageService: Hive database operations
- FirebaseService: Cloud sync operations

**Responsibilities:**
- Business rules implementation
- Data validation
- Service orchestration
- API integration

**Key Files:**
- `lib/services/recipe_service.dart`
- `lib/services/local_storage_service.dart`
- `lib/services/firebase_service.dart`

### 4. Data Layer

**Components:**
- Models: Data structures
- Hive Database: Local persistence
- Firebase: Cloud storage (optional)

**Responsibilities:**
- Data persistence
- Data models
- Database operations
- Cloud synchronization

**Key Files:**
- `lib/models/recipe.dart`
- `lib/models/user_settings.dart`
- Generated Hive adapters (`.g.dart` files)

## Data Flow

### Reading Data
```
User Action → Screen → Provider → Service → Database → Service → Provider → Screen → User
```

### Writing Data
```
User Input → Screen → Provider → Service → Database → Cloud (optional) → Provider → Screen
```

### Search Flow
```
User Search → RecipeProvider.searchRecipes() 
           → RecipeService.searchRecipes()
           → Filter local recipes
           → Return to provider
           → Update UI
```

## State Management Pattern

### Provider Pattern Implementation

```dart
// 1. Provider setup in main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => RecipeProvider()),
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
  ],
  child: MyApp(),
)

// 2. Provider usage in screens
class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    return ListView.builder(
      itemCount: provider.recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: provider.recipes[index]);
      },
    );
  }
}

// 3. State updates
class RecipeProvider with ChangeNotifier {
  void addRecipe(Recipe recipe) async {
    await _service.createRecipe(...);
    await loadRecipes();
    notifyListeners(); // UI updates automatically
  }
}
```

## Database Design

### Hive Boxes

#### Recipes Box
```dart
Box<Recipe> recipesBox
- Key: recipe.id (String)
- Value: Recipe object
- TypeAdapter: RecipeAdapter (typeId: 0)
```

#### Settings Box
```dart
Box<UserSettings> settingsBox
- Key: 'user_settings' (constant)
- Value: UserSettings object
- TypeAdapter: UserSettingsAdapter (typeId: 1)
```

### Why Hive?
- Fast, lightweight NoSQL database
- Type-safe with code generation
- Works offline
- Cross-platform (Android, iOS, Windows, etc.)
- No native dependencies
- Encrypted storage support

## Cloud Synchronization Architecture

### Firebase Integration (Optional)

```
Local Device                    Firebase Cloud
┌─────────────┐               ┌──────────────┐
│ Hive DB     │ ←──sync──→   │ Firestore    │
│  - Recipes  │               │  - Recipes   │
│  - Settings │               │  - Settings  │
└─────────────┘               └──────────────┘
       │                             │
       │                             │
┌─────────────┐               ┌──────────────┐
│ Local Files │ ←──upload─→  │ Storage      │
│  - Photos   │               │  - Photos    │
└─────────────┘               └──────────────┘
```

### Sync Strategy

**Offline-First:**
1. All operations work locally first
2. Changes queued for sync
3. Sync happens in background
4. Conflict resolution on merge

**Sync Triggers:**
- User enables cloud sync
- Manual sync button
- Background periodic sync
- App resume from background

## Navigation Architecture

### Navigation Flow

```
Home Screen (Bottom Nav)
├── Home Tab
│   ├── Recipe Detail
│   │   ├── Edit Recipe
│   │   └── Cooking Mode
│   └── Add Recipe
├── Recipes Tab
│   ├── Recipe List/Grid
│   │   └── Recipe Detail
│   │       ├── Edit Recipe
│   │       └── Cooking Mode
│   └── Search/Filter
└── Settings Tab
    ├── Theme Settings
    ├── Cloud Sync
    └── Backup/Export
```

### Navigation Implementation

Using Flutter's Navigator 2.0:
- Stack-based navigation
- Push/pop routes
- Named routes for deep linking
- Route guards for authentication

## Error Handling

### Strategies

1. **Local Operations:**
   - Try-catch blocks
   - User-friendly error messages
   - Graceful degradation

2. **Network Operations:**
   - Timeout handling
   - Retry logic
   - Offline fallback

3. **Database Operations:**
   - Transaction safety
   - Data validation
   - Backup before destructive operations

### Example

```dart
Future<void> saveRecipe(Recipe recipe) async {
  try {
    await LocalStorageService.saveRecipe(recipe);
    
    if (FirebaseService.isSignedIn && cloudSyncEnabled) {
      try {
        await FirebaseService.syncRecipe(recipe);
      } catch (e) {
        // Cloud sync failed, but local save succeeded
        // Queue for retry
        print('Cloud sync failed: $e');
      }
    }
  } catch (e) {
    // Critical error - local save failed
    throw Exception('Failed to save recipe: $e');
  }
}
```

## Performance Optimization

### Strategies

1. **Lazy Loading:**
   - Load recipes on demand
   - Pagination for large lists
   - Image lazy loading

2. **Caching:**
   - Cache search results
   - Cache filtered lists
   - Image thumbnail caching

3. **State Management:**
   - Selective rebuilds
   - Use Consumer<T> for specific updates
   - Minimize notifyListeners() calls

4. **Database:**
   - Indexed queries
   - Batch operations
   - Lazy box opening

## Security

### Local Security

1. **Data Encryption:**
   - Hive supports encrypted boxes
   - Secure key storage
   - Platform keychain integration

2. **Input Validation:**
   - Form validation
   - SQL injection prevention (N/A for Hive)
   - XSS prevention

### Cloud Security

1. **Firebase Security Rules:**
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId}/recipes/{recipeId} {
         allow read, write: if request.auth != null 
                           && request.auth.uid == userId;
       }
     }
   }
   ```

2. **Authentication:**
   - Email/password with validation
   - Google Sign-In
   - Token refresh handling

## Testing Strategy

### Test Pyramid

```
      ┌─────────────┐
      │   E2E Tests │  (Few)
      ├─────────────┤
      │Widget Tests │  (Some)
      ├─────────────┤
      │ Unit Tests  │  (Many)
      └─────────────┘
```

### Test Coverage

1. **Unit Tests:**
   - Models (serialization, validation)
   - Services (business logic)
   - Utilities (helpers, formatters)

2. **Widget Tests:**
   - Individual widgets
   - Screen layouts
   - User interactions

3. **Integration Tests:**
   - Database operations
   - API integration
   - State management flow

### Example Test

```dart
void main() {
  group('Recipe Model Tests', () {
    test('totalTime calculation', () {
      final recipe = Recipe(
        prepTime: 15,
        cookTime: 30,
        // ... other fields
      );
      expect(recipe.totalTime, 45);
    });
  });
}
```

## Deployment Architecture

### Build Configurations

**Debug:**
- Development Firebase config
- Debug logging enabled
- Hot reload supported

**Profile:**
- Performance profiling
- Limited logging
- Release optimizations

**Release:**
- Production Firebase config
- No logging
- Full optimizations
- Code obfuscation

### Platform Builds

**Android:**
- APK: Direct install
- AAB: Google Play Store
- Signing: Release keystore

**iOS:**
- IPA: App Store distribution
- Ad-hoc: Testing distribution
- Signing: Certificates & profiles

**Windows:**
- MSIX: Microsoft Store
- Portable: Direct distribution
- Installer: Setup wizard

## Scalability Considerations

### Current Scale
- Target: Single user, personal use
- Recipes: Up to 10,000 recipes
- Photos: 10 per recipe, 100,000 total
- Sync: Single user, multiple devices

### Future Scaling Options
- Multi-user support
- Recipe sharing
- Public recipe database
- Cloud-based search
- CDN for images

## Dependencies

### Core Dependencies
- **flutter**: Framework
- **provider**: State management
- **hive**: Local database
- **firebase_core**: Firebase SDK

### Feature Dependencies
- **image_picker**: Photo selection
- **google_mlkit_text_recognition**: OCR
- **speech_to_text**: Voice input
- **flutter_tts**: Text-to-speech
- **pdf**: PDF generation
- **google_fonts**: Typography

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Linting rules
- **build_runner**: Code generation
- **hive_generator**: Hive adapters

## Maintenance

### Regular Tasks
- Update dependencies monthly
- Review and fix deprecations
- Performance profiling quarterly
- Security audit bi-annually

### Monitoring
- Crash reporting (planned)
- Analytics (optional)
- User feedback
- Performance metrics

## Future Architecture Improvements

1. **Repository Pattern:**
   - Abstract data sources
   - Easier testing
   - Cleaner service layer

2. **Dependency Injection:**
   - GetIt or Injectable
   - Better testability
   - Loose coupling

3. **Clean Architecture:**
   - Domain layer
   - Use cases
   - Strict layer separation

4. **GraphQL:**
   - Alternative to REST
   - Better data fetching
   - Real-time subscriptions

5. **BLoC Pattern:**
   - Alternative to Provider
   - More structured
   - Better for complex apps
