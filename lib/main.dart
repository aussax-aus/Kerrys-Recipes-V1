import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/local_storage_service.dart';
import 'providers/recipe_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (optional - only if configured)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Firebase not configured, continue without it
  }
  
  // Initialize local storage
  await LocalStorageService.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()..loadRecipes()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..loadSettings()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'My Kitchen Book',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.isDarkMode 
                ? ThemeMode.dark 
                : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
