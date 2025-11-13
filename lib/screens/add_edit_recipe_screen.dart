import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import '../services/recipe_service.dart';

class AddEditRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddEditRecipeScreen({super.key, this.recipe});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedCategory = 'Other';
  String? _selectedDifficulty = 'Medium';
  final List<String> _tags = [];
  final List<String> _photos = [];

  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _loadRecipe(widget.recipe!);
    } else {
      _servingsController.text = '4';
      _prepTimeController.text = '0';
      _cookTimeController.text = '0';
    }
  }

  void _loadRecipe(Recipe recipe) {
    _titleController.text = recipe.title;
    _ingredientsController.text = recipe.ingredients.join('\n');
    _stepsController.text = recipe.steps.join('\n');
    _prepTimeController.text = recipe.prepTime.toString();
    _cookTimeController.text = recipe.cookTime.toString();
    _servingsController.text = recipe.servings.toString();
    _selectedCategory = recipe.category;
    _selectedDifficulty = recipe.difficulty;
    _tags.addAll(recipe.tags);
    _photos.addAll(recipe.photos);
    _notesController.text = recipe.notes ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.recipe != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Recipe' : 'New Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveRecipe,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Recipe Title',
                hintText: 'Enter recipe name',
                prefixIcon: Icon(Icons.restaurant),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
              ),
              items: _recipeService.getCategories().map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Times and Servings
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _prepTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Prep (min)',
                      prefixIcon: Icon(Icons.timer),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _cookTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Cook (min)',
                      prefixIcon: Icon(Icons.schedule),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _servingsController,
                    decoration: const InputDecoration(
                      labelText: 'Servings',
                      prefixIcon: Icon(Icons.people),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficulty,
                    decoration: const InputDecoration(
                      labelText: 'Difficulty',
                      prefixIcon: Icon(Icons.bar_chart),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Easy', child: Text('Easy')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'Hard', child: Text('Hard')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Ingredients
            Text('Ingredients', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                hintText: 'Enter each ingredient on a new line',
              ),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ingredients';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Steps
            Text('Instructions', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _stepsController,
              decoration: const InputDecoration(
                hintText: 'Enter each step on a new line',
              ),
              maxLines: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter instructions';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Tags
            Text('Tags', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._tags.map((tag) => Chip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          _tags.remove(tag);
                        });
                      },
                    )),
                ActionChip(
                  label: const Text('Add Tag'),
                  avatar: const Icon(Icons.add, size: 18),
                  onPressed: _addTag,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Notes
            Text('Notes', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Optional cooking notes, tips, or variations',
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 24),

            // Photos Section
            Text('Photos', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement photo picker
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Photo picker coming soon!')),
                );
              },
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('Add Photos'),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _addTag() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Tag'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Tag name'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    _tags.add(controller.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final ingredients = _ingredientsController.text
        .split('\n')
        .where((i) => i.trim().isNotEmpty)
        .toList();

    final steps = _stepsController.text
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();

    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    if (widget.recipe != null) {
      // Update existing recipe
      final updatedRecipe = widget.recipe!.copyWith(
        title: _titleController.text,
        ingredients: ingredients,
        steps: steps,
        category: _selectedCategory,
        tags: _tags,
        prepTime: int.parse(_prepTimeController.text),
        cookTime: int.parse(_cookTimeController.text),
        servings: int.parse(_servingsController.text),
        difficulty: _selectedDifficulty,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        photos: _photos,
      );
      await recipeProvider.updateRecipe(updatedRecipe);
    } else {
      // Create new recipe
      final newRecipe = Recipe(
        id: '',
        title: _titleController.text,
        ingredients: ingredients,
        steps: steps,
        photos: _photos,
        category: _selectedCategory,
        tags: _tags,
        prepTime: int.parse(_prepTimeController.text),
        cookTime: int.parse(_cookTimeController.text),
        servings: int.parse(_servingsController.text),
        isFavorite: false,
        dateAdded: DateTime.now(),
        difficulty: _selectedDifficulty,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );
      await recipeProvider.addRecipe(newRecipe);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.recipe != null 
              ? 'Recipe updated!' 
              : 'Recipe added!'),
        ),
      );
    }
  }
}
