import 'dart:collection';

import 'package:flutter/material.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String steps;

  const Recipe(
      {this.id, this.name, this.description, this.ingredients, this.steps});
}

class RecipeStore extends ChangeNotifier {
  final _recipes = [
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
  final _recipesById = <int, Recipe>{};

  UnmodifiableListView<Recipe> get recipes => UnmodifiableListView(_recipes);

  RecipeStore() {
    for (final recipe in _recipes) {
      _recipesById[recipe.id] = recipe;
    }
  }

  Recipe getRecipeById(int id) => _recipesById[id];

  void updateRecipe(Recipe recipe) {
    for (var i = 0; i < _recipes.length; ++i) {
      if (_recipes[i].id == recipe.id) {
        _recipes[i] = recipe;
        _recipesById[recipe.id] = recipe;
        break;
      }
    }
    notifyListeners();
  }
}
