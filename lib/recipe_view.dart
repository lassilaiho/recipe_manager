import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe.dart';
import 'recipe_details.dart';
import 'recipe_editor.dart';

class RecipeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Consumer<RecipeStore>(
        builder: (context, recipeStore, child) => ListView(
              padding: const EdgeInsets.all(8),
              children: recipeStore.recipes
                  .map((recipe) => Card(
                        key: Key(recipe.id.toString()),
                        child: ListTile(
                          title: Text(recipe.name),
                          trailing: PopupMenuButton<int>(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Text('Edit'),
                                  )
                                ],
                            onSelected: (choice) {
                              switch (choice) {
                                case 0:
                                  Navigator.push<RecipeDetails>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeEditor(
                                            initialRecipe: recipe,
                                            onEditFinished:
                                                recipeStore.updateRecipe,
                                          ),
                                    ),
                                  );
                              }
                            },
                          ),
                          onTap: () {
                            Navigator.push<RecipeDetails>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetails(recipe.id),
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(),
            ),
      ),
    );
  }
}
