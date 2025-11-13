import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../providers/settings_provider.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_grid_item.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  final bool showSearch;
  
  const RecipeListScreen({super.key, this.showSearch = false});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _isGridView = settings.defaultView == 'grid';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipes = recipeProvider.recipes;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: widget.showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  recipeProvider.searchRecipes(value);
                },
              )
            : const Text('All Recipes'),
        actions: [
          if (!widget.showSearch)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeListScreen(showSearch: true),
                  ),
                );
              },
            ),
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              recipeProvider.setSortBy(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'date',
                child: Text('Recently Added'),
              ),
              const PopupMenuItem(
                value: 'alphabetical',
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem(
                value: 'time',
                child: Text('Cooking Time'),
              ),
              const PopupMenuItem(
                value: 'favorites',
                child: Text('Favorites First'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: recipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 80,
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recipes found',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your search or filters',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : _isGridView
              ? GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipeGridItem(
                      recipe: recipe,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    );
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
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
                  },
                ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Recipes'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quick Filters', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  recipeProvider.setMaxTime(30);
                  Navigator.pop(context);
                },
                child: const Text('Quick Meals (<30 min)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  recipeProvider.setTags(['Vegetarian']);
                  Navigator.pop(context);
                },
                child: const Text('Vegetarian'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  recipeProvider.clearFilters();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear All Filters'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
