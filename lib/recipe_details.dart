import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe.dart';
import 'recipe_deletion_snack_bar.dart';
import 'recipe_editor.dart';

class RecipeDetails extends StatelessWidget {
  final int recipeId;

  const RecipeDetails(this.recipeId);

  @override
  Widget build(BuildContext context) {
    final recipeStore = Provider.of<RecipeStore>(context);
    if (!recipeStore.containsRecipe(recipeId)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Details'),
        ),
      );
    }
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push<RecipeEditor>(
                context,
                MaterialPageRoute(
                  builder: (context) => Consumer<RecipeStore>(
                        builder: (context, recipeStore, child) => RecipeEditor(
                              initialRecipe:
                                  recipeStore.getRecipeById(recipeId),
                              onEditFinished: recipeStore.updateRecipe,
                            ),
                      ),
                ),
              );
            },
          ),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: () async {
                Navigator.pop(
                  context,
                  RecipeDeletionAction(
                    recipeStore.removeRecipeWithDelay(
                      recipeId,
                      recipeDeletionUndoDuration,
                    ),
                    recipeDeletionUndoDuration,
                  ),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Consumer<RecipeStore>(
            builder: (context, recipeStore, child) {
              final recipe = recipeStore.getRecipeById(recipeId);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name.isEmpty ? 'Unnamed recipe' : recipe.name,
                      style: textTheme.headline),
                  if (recipe.description.isNotEmpty)
                    _padTop(Text(recipe.description)),
                  _padTop(Text(
                    'Ingredients',
                    style: textTheme.headline,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients
                          .map((ingredient) => Text('• $ingredient'))
                          .toList(),
                    ),
                  ),
                  _padTop(Text(
                    'Steps',
                    style: textTheme.headline,
                  )),
                  Text(recipe.steps),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _padTop(Widget child,
      {EdgeInsets padding = const EdgeInsets.only(top: 8)}) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
