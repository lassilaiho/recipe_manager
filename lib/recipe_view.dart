import 'package:flutter/material.dart';

import 'recipe.dart';
import 'recipe_details.dart';
import 'recipe_editor.dart';

class RecipeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final recipes = [
    const Recipe(
      id: 0,
      name: 'Example 1',
      description: 'An example recipe',
      ingredients: [
        'Ingredient 1',
        'Ingredient 2',
        'Ingredient 3',
      ],
      steps: 'Mix the ingredients',
    ),
    const Recipe(
      id: 1,
      name: 'Example 2',
      description: 'An example recipe',
      ingredients: [
        'Ingredient 1',
        'Ingredient 2',
        'Ingredient 3',
      ],
      steps: 'Mix the ingredients',
    ),
    const Recipe(
      id: 2,
      name: 'Example 3',
      description: 'An example recipe',
      ingredients: [
        'Ingredient 1',
        'Ingredient 2',
        'Ingredient 3',
      ],
      steps: 'Mix the ingredients',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: recipes
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
                                      onEditFinished: _updateRecipe,
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
                            builder: (context) => RecipeDetails(
                                  recipe: recipe,
                                  updateRecipe: _updateRecipe,
                                )),
                      );
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _updateRecipe(Recipe recipe) {
    setState(() {
      for (var i = 0; i < recipes.length; ++i) {
        if (recipes[i].id == recipe.id) {
          recipes[i] = recipe;
          break;
        }
      }
    });
  }
}
