import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_manager/app_localizations.dart';

import 'recipe.dart';
import 'recipe_deletion_snack_bar.dart';
import 'recipe_details.dart';
import 'recipe_editor.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeStore = Provider.of<RecipeStore>(context);
    final localizations = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        title: Text(recipe.displayName ?? localizations.unnamedRecipe),
        trailing: PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Text(localizations.edit),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(localizations.remove),
            )
          ],
          onSelected: (choice) {
            switch (choice) {
              case 0:
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeEditor(
                      initialRecipe: recipe,
                      onEditFinished: recipeStore.updateRecipe,
                      title: localizations.editRecipe,
                    ),
                  ),
                );
                break;
              case 1:
                showRecipeDeletionSnackBar(
                  context,
                  recipeStore.removeRecipeWithDelay(
                    recipe.id,
                    recipeDeletionUndoDuration,
                  ),
                  recipeDeletionUndoDuration,
                );
                break;
            }
          },
        ),
        onTap: () async {
          final result = await Navigator.push<RecipeDeletionAction>(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetails(recipe.id),
            ),
          );
          if (result != null) {
            showRecipeDeletionSnackBar(
              context,
              result.operation,
              result.duration,
            );
          }
        },
      ),
    );
  }
}
