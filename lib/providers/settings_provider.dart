import 'package:flutter/material.dart';
import '../models/user_settings.dart';
import '../services/local_storage_service.dart';
import '../services/firebase_service.dart';

class SettingsProvider with ChangeNotifier {
  UserSettings _settings = UserSettings();

  UserSettings get settings => _settings;
  bool get isDarkMode => _settings.darkMode;
  bool get isCloudSyncEnabled => _settings.cloudSyncEnabled;
  String get unitSystem => _settings.unitSystem;
  String get defaultView => _settings.defaultView;

  Future<void> loadSettings() async {
    _settings = LocalStorageService.getSettings();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _settings.darkMode = !_settings.darkMode;
    await _saveSettings();
  }

  Future<void> toggleCloudSync() async {
    _settings.cloudSyncEnabled = !_settings.cloudSyncEnabled;
    await _saveSettings();
    
    if (_settings.cloudSyncEnabled) {
      // Trigger initial sync
      await _syncToCloud();
    }
  }

  Future<void> setUnitSystem(String system) async {
    _settings.unitSystem = system;
    await _saveSettings();
  }

  Future<void> setDefaultView(String view) async {
    _settings.defaultView = view;
    await _saveSettings();
  }

  Future<void> setUserEmail(String? email) async {
    _settings.userEmail = email;
    await _saveSettings();
  }

  Future<void> updateLastBackup() async {
    _settings.lastBackup = DateTime.now();
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    await LocalStorageService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> _syncToCloud() async {
    if (FirebaseService.isSignedIn && _settings.cloudSyncEnabled) {
      await FirebaseService.syncSettings(_settings);
    }
  }

  Future<void> syncFromCloud() async {
    if (FirebaseService.isSignedIn && _settings.cloudSyncEnabled) {
      final cloudSettings = await FirebaseService.fetchSettings();
      if (cloudSettings != null) {
        _settings = cloudSettings;
        await LocalStorageService.saveSettings(_settings);
        notifyListeners();
      }
    }
  }
}
