import 'package:flutter/material.dart';

import 'recipe.dart';
import 'recipe_editor.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  final void Function(Recipe) updateRecipe;

  const RecipeDetails({this.recipe, this.updateRecipe});

  @override
  Widget build(BuildContext context) {
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
                      builder: (context) => RecipeEditor(
                            initialRecipe: recipe,
                            onEditFinished: updateRecipe,
                          )));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.name, style: textTheme.headline),
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Steps',
                style: textTheme.headline,
              ),
            ),
            Text(recipe.steps),
          ],
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
