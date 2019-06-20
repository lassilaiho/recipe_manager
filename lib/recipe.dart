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

  Recipe withId(int value) => Recipe(
        id: value,
        name: name,
        description: description,
        ingredients: ingredients,
        steps: steps,
      );
}

class RecipeStore extends ChangeNotifier {
  final _recipes = <Recipe>[];
  final _recipesById = <int, Recipe>{};
  var _idCounter = 0;

  UnmodifiableListView<Recipe> get recipes => UnmodifiableListView(_recipes);

  RecipeStore() {
    for (final recipe in _recipes) {
      _recipesById[recipe.id] = recipe;
    }
  }

  Recipe getRecipeById(int id) => _recipesById[id];

  bool containsRecipe(int id) => _recipesById.containsKey(id);

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

  Recipe addRecipe(Recipe recipe) {
    final newRecipe = recipe.withId(_idCounter++);
    _recipes.add(newRecipe);
    _recipesById[newRecipe.id] = newRecipe;
    notifyListeners();
    return newRecipe;
  }

  void removeRecipe(int id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
    _recipesById.remove(id);
    notifyListeners();
  }
}
