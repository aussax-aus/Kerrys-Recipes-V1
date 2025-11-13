import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../models/recipe.dart';
import 'recipe_list_screen.dart';
import 'recipe_detail_screen.dart';
import 'add_edit_recipe_screen.dart';
import 'settings_screen.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeTab(),
          RecipeListScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditRecipeScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New Recipe'),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final theme = Theme.of(context);
    
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('My Kitchen Book'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeListScreen(showSearch: true),
                  ),
                );
              },
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Welcome Message
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Your Kitchen Book',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your personal collection of recipes',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.menu_book,
                      label: 'Total Recipes',
                      value: '${recipeProvider.recipes.length}',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.favorite,
                      label: 'Favorites',
                      value: '${recipeProvider.favoriteRecipes.length}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Favorite Recipes Section
              if (recipeProvider.favoriteRecipes.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Favorite Recipes',
                      style: theme.textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecipeListScreen(),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...recipeProvider.favoriteRecipes.take(3).map((recipe) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],

              // Recent Recipes Section
              if (recipeProvider.recipes.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Recent Recipes',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...recipeProvider.recipes.take(3).map((recipe) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],

              // Empty State
              if (recipeProvider.recipes.isEmpty) ...[
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 80,
                        color: theme.colorScheme.primary.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recipes yet',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the + button to add your first recipe',
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 80), // Space for FAB
            ]),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              label,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
