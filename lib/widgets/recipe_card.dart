import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.primaryContainer,
                ),
                child: recipe.photos.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          recipe.photos.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant,
                              color: theme.colorScheme.onPrimaryContainer,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.restaurant,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            recipe.title,
                            style: theme.textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: recipe.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            recipeProvider.toggleFavorite(recipe);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.category,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: theme.colorScheme.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.totalTime} min',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.people, size: 16, color: theme.colorScheme.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.servings}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
