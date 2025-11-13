# Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Prerequisites

Make sure you have Flutter installed:
```bash
flutter --version
```

If not installed, visit: https://flutter.dev/docs/get-started/install

### Step 2: Clone and Setup

```bash
# Clone the repository
git clone https://github.com/aussax-aus/Kerrys-Recipes-V1.git
cd Kerrys-Recipes-V1

# Get dependencies
flutter pub get

# Check everything is ready
flutter doctor
```

### Step 3: Run the App

Choose your platform:

**Android (Emulator or Device):**
```bash
flutter run -d android
```

**iOS (Simulator or Device - macOS only):**
```bash
flutter run -d ios
```

**Windows (Desktop):**
```bash
flutter run -d windows
```

### Step 4: Add Your First Recipe

1. Tap the **"+ New Recipe"** button
2. Fill in the recipe details:
   - Title (e.g., "Chocolate Chip Cookies")
   - Ingredients (one per line)
   - Steps (one per line)
   - Category, times, servings
3. Tap the **checkmark** to save

### Step 5: Try Cooking Mode

1. Open a recipe
2. Tap **"Start Cooking"**
3. Follow step-by-step instructions
4. Use the built-in timer if needed

## 📱 App Navigation

```
┌─────────────────────────────────────┐
│         My Kitchen Book             │
├─────────────────────────────────────┤
│                                     │
│  [Home] [Recipes] [Settings]       │  ← Bottom Navigation
│                                     │
└─────────────────────────────────────┘

Home Tab:
  - Welcome message
  - Recipe stats
  - Favorite recipes
  - Recent recipes
  - [+ New Recipe] button

Recipes Tab:
  - All recipes (Grid or List)
  - Search bar
  - Sort & Filter options
  - Tap recipe to view details

Settings Tab:
  - Dark Mode toggle
  - Unit system
  - Cloud Sync (optional)
  - Backup options
```

## 🎨 Theme Switching

**Enable Dark Mode:**
1. Tap **Settings** (bottom right)
2. Toggle **Dark Mode** switch
3. Enjoy the cozy dark theme!

**Change View:**
1. In Recipes tab, tap the **grid/list icon**
2. Or set default in Settings

## 🔍 Search & Filter

**Search:**
- In Recipes tab, tap **search icon**
- Type recipe name, ingredient, or tag
- Results update in real-time

**Sort:**
- Tap **sort icon** (three lines)
- Choose: Recently Added, Alphabetical, Cooking Time, or Favorites

**Filter:**
- Tap **filter icon**
- Quick Meals: Shows recipes under 30 minutes
- Vegetarian: Shows veggie recipes
- Clear All: Removes all filters

## ⭐ Favorite Recipes

**Mark as Favorite:**
- In recipe detail, tap the **heart icon**
- Or tap heart on recipe cards

**View Favorites:**
- Go to Home tab
- Scroll to "Favorite Recipes" section

## 👨‍🍳 Cooking Mode

**Start Cooking:**
1. Open any recipe
2. Tap **"Start Cooking"** button
3. Navigate: **Previous** / **Next**
4. Check off completed steps
5. Set timers as needed

**Timer:**
1. In cooking mode, tap **timer icon**
2. Enter minutes
3. Tap **Start**
4. Get notified when done

## 🔄 Cloud Sync (Optional)

**Enable Sync:**
1. Go to Settings
2. Toggle **Cloud Sync**
3. Sign in with email/password
4. Your recipes sync across devices!

**Note:** Cloud sync requires Firebase configuration. The app works perfectly offline without it.

## 🏷️ Categories & Tags

**Categories:**
- Breakfast, Lunch, Dinner
- Dessert, Snack, Appetizer
- Beverage, Soup, Salad, Other

**Popular Tags:**
- Quick, Healthy, Vegetarian
- Vegan, Gluten-Free, Low-Carb
- High-Protein, Kid-Friendly
- One-Pot, Meal-Prep

## 💡 Pro Tips

1. **Use Tags:** Add tags like "Quick" or "Healthy" for easy filtering
2. **Add Photos:** Visual recipes are more appealing
3. **Detailed Steps:** Break down complex steps for clarity
4. **Use Cooking Mode:** Keep your device clean with large text
5. **Set Timers:** Never overcook again!
6. **Favorite Often:** Quick access to go-to recipes
7. **Search Everything:** Search works on ingredients too
8. **Try Dark Mode:** Perfect for evening cooking

## 🐛 Troubleshooting

**App won't run?**
```bash
flutter clean
flutter pub get
flutter run
```

**Can't find devices?**
- Android: Enable USB debugging
- iOS: Trust computer in iPhone settings
- Windows: Should work on local machine

**Build errors?**
```bash
cd android && ./gradlew clean && cd ..
flutter clean
flutter pub get
```

## 📚 Learn More

- **Full Documentation:** See README.md
- **Development Guide:** See DEVELOPMENT.md
- **Features List:** See FEATURES.md
- **Architecture:** See ARCHITECTURE.md

## 🆘 Need Help?

1. Check the documentation files
2. Run `flutter doctor` to verify setup
3. Check Flutter documentation: https://flutter.dev/docs
4. Open an issue on GitHub

## 🎉 You're Ready!

Start adding your favorite recipes and enjoy cooking with My Kitchen Book!

---

**Tip:** Take 5 minutes to add 2-3 recipes to get a feel for the app. Then explore all the features!
