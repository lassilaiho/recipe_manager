import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe.dart';
import 'recipe_card.dart';
import 'recipe_editor.dart';
import 'search_app_bar.dart';

class RecipeView extends StatefulWidget {
  RecipeView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  var _isSearching = false;
  var _searchString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? SearchAppBar(
              onChanged: (searchString) =>
                  setState(() => _searchString = searchString),
              onBack: () => setState(() {
                    _isSearching = false;
                    _searchString = '';
                  }),
            )
          : _defaultAppBar(),
      body: Consumer<RecipeStore>(
        builder: (context, recipeStore, child) => ListView(
              padding: const EdgeInsets.all(8),
              children: _constructRecipeCards(recipeStore),
            ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isSearching ? 0 : 1,
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeEditor(
                      initialRecipe: null,
                      onEditFinished:
                          Provider.of<RecipeStore>(context).addRecipe,
                      title: 'Add Recipe',
                    ),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _defaultAppBar() => AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => setState(() => _isSearching = true),
          )
        ],
      );

  List<Widget> _constructRecipeCards(RecipeStore store) {
    Iterable<Recipe> recipesToShow = store.recipes;
    if (_isSearching) {
      if (_searchString.isEmpty) {
        return [];
      }
      final pattern = RegExp(
        RegExp.escape(_searchString),
        caseSensitive: false,
      );
      recipesToShow =
          recipesToShow.where((recipe) => recipe.fieldsContain(pattern));
    }
    return recipesToShow
        .map((recipe) => RecipeCard(
              key: Key(recipe.id.toString()),
              recipe: recipe,
            ))
        .toList();
  }
}
