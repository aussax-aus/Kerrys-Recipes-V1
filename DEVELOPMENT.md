# Development Guide

## Getting Started

### Prerequisites

1. **Flutter SDK**
   - Install Flutter 3.0.0 or higher
   - Verify installation: `flutter doctor`
   - Add Flutter to your PATH

2. **Platform-Specific Requirements**

   **For Android Development:**
   - Android Studio with Android SDK
   - Android SDK version 24 or higher
   - Java Development Kit (JDK) 11 or higher

   **For iOS Development (macOS only):**
   - Xcode 14 or higher
   - CocoaPods: `sudo gem install cocoapods`
   - iOS Simulator or physical device

   **For Windows Development:**
   - Visual Studio 2022 with C++ development tools
   - Windows 10 SDK or higher

### Initial Setup

1. Clone the repository:
```bash
git clone https://github.com/aussax-aus/Kerrys-Recipes-V1.git
cd Kerrys-Recipes-V1
```

2. Install dependencies:
```bash
flutter pub get
```

3. Verify everything is set up:
```bash
flutter doctor -v
```

## Running the App

### Development Mode

**Android:**
```bash
# With device connected or emulator running
flutter run -d android

# Or specify a device
flutter devices
flutter run -d <device-id>
```

**iOS (macOS only):**
```bash
# Open iOS Simulator first, then:
flutter run -d ios

# Or for physical device:
flutter run -d <device-name>
```

**Windows:**
```bash
flutter run -d windows
```

### Hot Reload

While the app is running:
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

## Building for Production

### Android

**Build APK:**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

**Build App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS

**Build for release:**
```bash
flutter build ios --release
```

**Create IPA:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Product > Archive
3. Follow the export wizard

### Windows

**Build executable:**
```bash
flutter build windows --release
```
Output: `build/windows/runner/Release/`

## Testing

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Specific Test File
```bash
flutter test test/recipe_test.dart
```

## Code Quality

### Analyze Code
```bash
flutter analyze
```

### Format Code
```bash
flutter format lib/
```

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/                        # Data models
│   ├── recipe.dart               # Recipe model
│   ├── recipe.g.dart             # Generated Hive adapter
│   ├── user_settings.dart        # User settings model
│   └── user_settings.g.dart      # Generated Hive adapter
├── services/                      # Business logic layer
│   ├── local_storage_service.dart # Hive storage operations
│   ├── recipe_service.dart        # Recipe CRUD operations
│   └── firebase_service.dart      # Cloud sync (optional)
├── providers/                     # State management
│   ├── recipe_provider.dart       # Recipe state
│   └── settings_provider.dart     # Settings state
├── screens/                       # UI screens
│   ├── home_screen.dart          # Main dashboard
│   ├── recipe_list_screen.dart   # Browse recipes
│   ├── recipe_detail_screen.dart # View recipe details
│   ├── add_edit_recipe_screen.dart # Create/edit recipes
│   ├── cooking_mode_screen.dart  # Step-by-step cooking guide
│   └── settings_screen.dart      # App settings
├── widgets/                       # Reusable UI components
│   ├── recipe_card.dart          # Recipe card for list view
│   └── recipe_grid_item.dart     # Recipe card for grid view
└── utils/                         # Utilities
    ├── theme.dart                # App theme configuration
    ├── constants.dart            # App constants
    └── date_formatter.dart       # Date formatting utilities
```

## Firebase Setup (Optional)

Cloud sync is optional. The app works perfectly offline without Firebase.

### To Enable Cloud Sync:

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create a new project
   - Add Android and/or iOS app

2. **Enable Services**
   - Authentication: Enable Email/Password and Google Sign-In
   - Firestore Database: Create database in test mode
   - Storage: Enable Firebase Storage

3. **Download Configuration Files**
   
   **For Android:**
   - Download `google-services.json`
   - Place in `android/app/`

   **For iOS:**
   - Download `GoogleService-Info.plist`
   - Place in `ios/Runner/`

4. **Rebuild the app**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## Common Issues and Solutions

### Issue: "No devices found"
**Solution:** 
- Android: Start an emulator or connect a device with USB debugging enabled
- iOS: Open Simulator or connect iPhone
- Windows: Run on local machine

### Issue: Build fails on Android
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: iOS Pods not installing
**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

### Issue: Hot reload not working
**Solution:**
- Press `R` for hot restart instead of `r`
- Or fully stop and restart the app

## Debugging

### Enable Debug Mode
```bash
flutter run --debug
```

### View Logs
```bash
# Android
flutter logs

# Or use device-specific:
adb logcat
```

### Performance Profiling
```bash
flutter run --profile
```

Then open DevTools:
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

## Contributing

1. Create a feature branch
2. Make changes
3. Run tests: `flutter test`
4. Format code: `flutter format lib/`
5. Analyze: `flutter analyze`
6. Commit and push

## Troubleshooting

### Clear Cache
```bash
flutter clean
flutter pub get
```

### Update Dependencies
```bash
flutter pub upgrade
```

### Check Flutter Version
```bash
flutter --version
```

### Upgrade Flutter
```bash
flutter upgrade
```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io/)

## Support

For issues or questions:
1. Check the README.md
2. Review this development guide
3. Check Flutter documentation
4. Open an issue on GitHub
