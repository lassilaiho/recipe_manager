import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String steps;

  final String displayName;

  Recipe({this.id, this.name, this.description, this.ingredients, this.steps})
      : displayName = name.isEmpty ? null : name;

  Recipe withId(int value) => Recipe(
        id: value,
        name: name,
        description: description,
        ingredients: ingredients,
        steps: steps,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'ingredients': ingredients.join('\n'),
        'steps': steps,
      };

  bool fieldsContain(Pattern pattern) {
    final result = displayName?.contains(pattern) ??
        false || description.contains(pattern);
    if (!result) {
      for (final ingredient in ingredients) {
        if (ingredient.contains(pattern)) {
          return true;
        }
      }
    }
    return result || steps.contains(pattern);
  }
}

class RecipeStore extends ChangeNotifier {
  final _recipes = <Recipe>[];
  final _recipesById = <int, Recipe>{};
  Database _database;

  UnmodifiableListView<Recipe> get recipes => UnmodifiableListView(_recipes);

  RecipeStore(String databaseName) {
    _loadDatabase(databaseName);
  }

  Recipe getRecipeById(int id) => _recipesById[id];

  bool containsRecipe(int id) => _recipesById.containsKey(id);

  Future<void> updateRecipe(Recipe recipe) async {
    final future = _database.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: <dynamic>[recipe.id],
    );
    for (var i = 0; i < _recipes.length; ++i) {
      if (_recipes[i].id == recipe.id) {
        _recipes[i] = recipe;
        _recipesById[recipe.id] = recipe;
        break;
      }
    }
    await future;
    notifyListeners();
  }

  Future<Recipe> addRecipe(Recipe recipe, {bool autoAssignId = true}) async {
    final id = await _database.insert('recipes', <String, dynamic>{
      if (!autoAssignId) 'id': recipe.id,
      'name': recipe.name,
      'description': recipe.description,
      'ingredients': recipe.ingredients.join('\n'),
      'steps': recipe.steps,
    });
    final newRecipe = recipe.withId(id);
    _recipes.add(newRecipe);
    _recipesById[newRecipe.id] = newRecipe;
    notifyListeners();
    return newRecipe;
  }

  Future<void> removeRecipe(int id) async {
    final future =
        _database.delete('recipes', where: 'id = ?', whereArgs: <dynamic>[id]);
    _recipes.removeWhere((recipe) => recipe.id == id);
    _recipesById.remove(id);
    await future;
    notifyListeners();
  }

  CancelableOperation<void> removeRecipeWithDelay(int id, Duration delay) {
    final completer = CancelableCompleter<void>();
    final i = _recipes.indexWhere((recipe) => recipe.id == id);
    if (i == -1) {
      completer.complete();
      return completer.operation;
    }
    final recipe = _recipes[i];
    _recipes.removeAt(i);
    _recipesById.remove(id);
    notifyListeners();
    () async {
      await completer.operation.valueOrCancellation();
      if (completer.isCanceled) {
        _recipes.insert(
          i > _recipes.length ? _recipes.length : i,
          recipe,
        );
        _recipesById[id] = recipe;
        notifyListeners();
      }
    }();
    Timer(delay, () async {
      if (!completer.isCanceled) {
        await _database
            .delete('recipes', where: 'id = ?', whereArgs: <dynamic>[id]);
        completer.complete();
      }
    });
    return completer.operation;
  }

  Future<void> _loadDatabase(String name) async {
    _database = await openDatabase(
      path.join(await getDatabasesPath(), name),
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE recipes(
          id INTEGER PRIMARY KEY NOT NULL,
          name TEXT NOT NULL DEFAULT '',
          description TEXT NOT NULL DEFAULT '',
          ingredients TEXT NOT NULL DEFAULT '',
          steps TEXT NOT NULL DEFAULT ''
        )'''),
    );
    for (final map in await _database.query('recipes')) {
      final ingredients = map['ingredients'] as String;
      final recipe = Recipe(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        ingredients: ingredients.isEmpty ? [] : ingredients.split('\n'),
        steps: map['steps'] as String,
      );
      _recipes.add(recipe);
      _recipesById[recipe.id] = recipe;
    }
    notifyListeners();
  }
}
