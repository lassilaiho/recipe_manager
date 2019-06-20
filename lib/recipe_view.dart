import 'package:flutter/material.dart';

import 'recipe.dart';
import 'recipe_details.dart';

class RecipeView extends StatelessWidget {
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
                  child: ListTile(
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push<RecipeDetails>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetails(recipe)),
                      );
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
