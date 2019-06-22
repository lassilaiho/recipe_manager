import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Card(
      child: ListTile(
        title: Text(recipe.displayName),
        trailing: PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 0,
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Remove'),
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
