import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/firebase_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Appearance',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: settingsProvider.isDarkMode,
            onChanged: (value) {
              settingsProvider.toggleDarkMode();
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            title: const Text('Default View'),
            subtitle: Text('Currently: ${settingsProvider.defaultView}'),
            leading: const Icon(Icons.view_module),
            trailing: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'grid', label: Text('Grid')),
                ButtonSegment(value: 'list', label: Text('List')),
              ],
              selected: {settingsProvider.defaultView},
              onSelectionChanged: (Set<String> newSelection) {
                settingsProvider.setDefaultView(newSelection.first);
              },
            ),
          ),

          const Divider(),

          // Measurements Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Measurements',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            title: const Text('Unit System'),
            subtitle: Text(settingsProvider.unitSystem),
            leading: const Icon(Icons.straighten),
            trailing: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'metric', label: Text('Metric')),
                ButtonSegment(value: 'imperial', label: Text('Imperial')),
              ],
              selected: {settingsProvider.unitSystem},
              onSelectionChanged: (Set<String> newSelection) {
                settingsProvider.setUnitSystem(newSelection.first);
              },
            ),
          ),

          const Divider(),

          // Cloud Sync Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Cloud Sync',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Cloud Sync'),
            subtitle: Text(
              FirebaseService.isSignedIn
                  ? 'Signed in: ${FirebaseService.currentUser?.email}'
                  : 'Enable to sync across devices',
            ),
            value: settingsProvider.isCloudSyncEnabled,
            onChanged: (value) async {
              if (value && !FirebaseService.isSignedIn) {
                // Show login dialog
                _showLoginDialog(context, settingsProvider);
              } else {
                settingsProvider.toggleCloudSync();
              }
            },
            secondary: const Icon(Icons.cloud),
          ),
          if (FirebaseService.isSignedIn)
            ListTile(
              title: const Text('Sign Out'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseService.signOut();
                settingsProvider.setUserEmail(null);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signed out successfully')),
                  );
                }
              },
            ),

          const Divider(),

          // Backup Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Backup & Export',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            title: const Text('Export Recipes'),
            subtitle: const Text('Export all recipes as JSON'),
            leading: const Icon(Icons.download),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export feature coming soon!')),
              );
            },
          ),
          ListTile(
            title: const Text('Import Recipes'),
            subtitle: const Text('Import recipes from JSON file'),
            leading: const Icon(Icons.upload),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Import feature coming soon!')),
              );
            },
          ),
          if (settingsProvider.settings.lastBackup != null)
            ListTile(
              title: const Text('Last Backup'),
              subtitle: Text(
                _formatDate(settingsProvider.settings.lastBackup!),
              ),
              leading: const Icon(Icons.backup),
            ),

          const Divider(),

          // About Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'About',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const ListTile(
            title: Text('Version'),
            subtitle: Text('1.0.0'),
            leading: Icon(Icons.info),
          ),
          const ListTile(
            title: Text('My Kitchen Book'),
            subtitle: Text('Cross-platform recipe manager'),
            leading: Icon(Icons.restaurant_menu),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context, SettingsProvider settingsProvider) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseService.signInWithEmail(
                  emailController.text,
                  passwordController.text,
                );
                await settingsProvider.setUserEmail(emailController.text);
                await settingsProvider.toggleCloudSync();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signed in successfully!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
