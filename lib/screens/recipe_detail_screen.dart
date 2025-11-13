import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import 'add_edit_recipe_screen.dart';
import 'cooking_mode_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title),
              background: recipe.photos.isNotEmpty
                  ? Image.network(
                      recipe.photos.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.restaurant,
                            size: 80,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.restaurant,
                        size: 80,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  recipeProvider.toggleFavorite(recipe);
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditRecipeScreen(recipe: recipe),
                      ),
                    );
                  } else if (value == 'delete') {
                    _showDeleteDialog(context, recipeProvider);
                  } else if (value == 'share') {
                    // Implement share
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'share', child: Text('Share')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Recipe Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _InfoChip(
                              icon: Icons.timer,
                              label: 'Prep',
                              value: '${recipe.prepTime} min',
                            ),
                            _InfoChip(
                              icon: Icons.schedule,
                              label: 'Cook',
                              value: '${recipe.cookTime} min',
                            ),
                            _InfoChip(
                              icon: Icons.people,
                              label: 'Serves',
                              value: '${recipe.servings}',
                            ),
                          ],
                        ),
                        if (recipe.difficulty != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.bar_chart, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Difficulty: ${recipe.difficulty}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Category and Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text(recipe.category),
                      backgroundColor: theme.colorScheme.secondaryContainer,
                    ),
                    ...recipe.tags.map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: theme.colorScheme.tertiaryContainer,
                        )),
                  ],
                ),

                const SizedBox(height: 24),

                // Ingredients
                Text(
                  'Ingredients',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients
                          .map((ingredient) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        ingredient,
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Instructions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Instructions',
                      style: theme.textTheme.titleLarge,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CookingModeScreen(recipe: recipe),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Cooking'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.steps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: theme.colorScheme.primary,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Notes
                if (recipe.notes != null && recipe.notes!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Notes',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        recipe.notes!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, RecipeProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: const Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteRecipe(recipe.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.titleMedium),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
