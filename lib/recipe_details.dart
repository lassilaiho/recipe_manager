import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:provider/provider.dart';
import 'package:recipe_manager/app_localizations.dart';

import 'recipe.dart';
import 'recipe_deletion_snack_bar.dart';
import 'recipe_editor.dart';

class RecipeDetails extends StatelessWidget {
  final int recipeId;

  const RecipeDetails(this.recipeId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeStore = Provider.of<RecipeStore>(context);
    final localizations = AppLocalizations.of(context);
    if (!recipeStore.containsRecipe(recipeId)) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.detailsTitle),
        ),
      );
    }
    final recipe = recipeStore.getRecipeById(recipeId);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.detailsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: localizations.copyIngredients,
            onPressed: () {
              Clipboard.setData(
                  ClipboardData(text: recipe.ingredients.join('\n')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: localizations.edit,
            onPressed: () {
              Navigator.push<RecipeEditor>(
                context,
                MaterialPageRoute(
                  builder: (context) => Consumer<RecipeStore>(
                    builder: (context, recipeStore, child) => RecipeEditor(
                      initialRecipe: recipeStore.getRecipeById(recipeId),
                      onEditFinished: recipeStore.updateRecipe,
                      title: localizations.editRecipe,
                    ),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: localizations.delete,
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.displayName ?? localizations.unnamedRecipe,
                  style: textTheme.headline),
              if (recipe.description.isNotEmpty)
                _padTop(Text(recipe.description)),
              _padTop(Text(
                localizations.ingredients,
                style: textTheme.headline,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recipe.ingredients
                      .map((ingredient) =>
                          Text(ingredient.isEmpty ? '' : '• $ingredient'))
                      .toList(),
                ),
              ),
              _padTop(Text(
                localizations.steps,
                style: textTheme.headline,
              )),
              Text(recipe.steps),
            ],
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
