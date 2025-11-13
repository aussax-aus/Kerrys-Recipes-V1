import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeGridItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeGridItem({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  recipe.photos.isNotEmpty
                      ? Image.network(
                          recipe.photos.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.restaurant,
                                size: 48,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.restaurant,
                            size: 48,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                  // Favorite badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          recipe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          recipeProvider.toggleFavorite(recipe);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: theme.colorScheme.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.totalTime}m',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Icon(Icons.people, size: 14, color: theme.colorScheme.secondary),
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
            ),
          ],
        ),
      ),
    );
  }
}
