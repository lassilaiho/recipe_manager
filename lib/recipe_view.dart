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
      body: Consumer<RecipeStore>(builder: _recipeCardListBuilder),
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

  Widget _recipeCardListBuilder(
      BuildContext context, RecipeStore store, Widget child) {
    Iterable<Recipe> recipesToShow = store.recipes;
    if (_isSearching) {
      if (_searchString.isEmpty) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: const [],
        );
      }
      final pattern = RegExp(
        RegExp.escape(_searchString),
        caseSensitive: false,
      );
      recipesToShow =
          recipesToShow.where((recipe) => recipe.fieldsContain(pattern));
    }
    final recipes = recipesToShow.toList();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          key: Key(recipe.id.toString()),
          recipe: recipe,
        );
      },
    );
  }
}
