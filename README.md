# My Kitchen Book – Cross-Platform Recipe Manager

A modern, hybrid, offline-first recipe manager that works seamlessly across Android, iOS, and Windows desktop PCs, keeping personal recipes safe, synced, and beautifully designed.

## 🎯 Vision

Create a private personal recipe app for one user that:

- ✅ Works on phones, tablets, and Windows computers
- ✅ Stores everything offline but can sync online
- ✅ Supports rich features like photos, step tracking, timers, OCR, voice dictation
- ✅ Has a beautiful "warm kitchen" design
- ✅ Requires no external accounts unless cloud backup is enabled

This becomes the user's digital scrapbook cookbook.

## 🧩 Core Features

### 🥘 Recipe Management
- Add, edit, and delete recipes
- Complete recipe fields:
  - Name, Ingredients, Steps/instructions
  - Prep time, Cook time, Total time (auto-calculated)
  - Servings, Category, Tags
  - Difficulty level, Star/Favorite indicator
  - Date added, Notes

### 📷 Photo System
- Add up to 10 photos per recipe
- Gallery view for recipe photos
- Local storage with thumbnail caching

### 🔍 Search & Navigation
- Deep search by recipe name, ingredients, tags, category
- Sort by: Recently added, Alphabetical, Cooking time, Favorites
- Filters: Category, Tags, Quick meals (<30 mins)

### 🔌 Offline + Cloud Hybrid Sync
- **Offline Mode (always available):**
  - Local SQLite/Hive storage
  - Works fully offline—no login needed
- **Cloud Sync (optional toggle):**
  - Firebase Authentication (Email/Google)
  - Firestore sync of recipes, photos, settings
  - Background sync across devices

### ⏱️ Cooking Assistant
- Step-by-step cooking mode
- Built-in cooking timers
- Mark steps as completed
- Perfect for cooking with messy hands

### 🎨 Design Theme: Warm Kitchen
- **Light Mode:** Soft browns, cream whites, muted reds
- **Dark Mode:** Amber highlight, Elderberry purple accents, Soft slate backgrounds
- Rounded cards with shadows like recipe cards on a wooden table
- Clean typography: Poppins/Merriweather headers, Open Sans body text

## 🖥️ Platform Support
- ✅ Android
- ✅ iOS
- ✅ Windows 11 (and Windows 10)

## ⚙️ Technology Stack

### Frontend
- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **Local Storage:** Hive (lightweight, cross-platform)

### Cloud (Optional)
- **Authentication:** Firebase Auth
- **Database:** Cloud Firestore
- **Storage:** Firebase Storage (photos)

### Features
- **Photos:** image_picker, photo_view
- **OCR:** google_mlkit_text_recognition
- **Voice:** speech_to_text, flutter_tts
- **Export:** PDF generation, JSON backup

## 📦 Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- For Android: Android Studio
- For iOS: Xcode
- For Windows: Visual Studio 2022 with C++ tools

### Setup

1. Clone the repository:
```bash
git clone https://github.com/aussax-aus/Kerrys-Recipes-V1.git
cd Kerrys-Recipes-V1
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# For Android
flutter run -d android

# For iOS
flutter run -d ios

# For Windows
flutter run -d windows
```

## 🔥 Firebase Setup (Optional)

To enable cloud sync features:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable Authentication (Email/Password and Google Sign-In)
3. Enable Cloud Firestore
4. Enable Firebase Storage
5. Download configuration files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
6. Run the app

Without Firebase configuration, the app works perfectly in offline mode only.

## 🚀 Build for Release

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Windows
```bash
flutter build windows --release
```

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── recipe.dart
│   └── user_settings.dart
├── services/                 # Business logic
│   ├── local_storage_service.dart
│   ├── recipe_service.dart
│   └── firebase_service.dart
├── providers/                # State management
│   ├── recipe_provider.dart
│   └── settings_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── recipe_list_screen.dart
│   ├── recipe_detail_screen.dart
│   ├── add_edit_recipe_screen.dart
│   ├── cooking_mode_screen.dart
│   └── settings_screen.dart
├── widgets/                  # Reusable widgets
│   ├── recipe_card.dart
│   └── recipe_grid_item.dart
└── utils/                    # Utilities
    └── theme.dart
```

## 🧪 Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📱 Features Demo

### Home Screen
- Welcome message
- Quick stats (total recipes, favorites)
- Featured and recent recipes
- Quick navigation

### Recipe List
- Grid or list view toggle
- Search functionality
- Sort and filter options
- Category filtering

### Recipe Detail
- Full recipe information
- Photo gallery
- Ingredients checklist
- Step-by-step instructions
- Favorite toggle
- Edit and delete options

### Cooking Mode
- Step-by-step guide
- Progress tracking
- Built-in timer
- Mark steps complete

### Settings
- Dark/Light mode toggle
- Unit system (Metric/Imperial)
- Default view preference
- Cloud sync toggle
- Backup and export options

## 🤝 Contributing

This is a personal project, but suggestions and feedback are welcome!

## 📄 License

This project is created for personal use. All rights reserved.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for cloud services
- Google Fonts for beautiful typography

---

**Made with ❤️ for Kerry's Kitchen**