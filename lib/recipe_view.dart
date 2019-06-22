import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe.dart';
import 'recipe_card.dart';
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
                  .map((recipe) => RecipeCard(
                        key: Key(recipe.id.toString()),
                        recipe: recipe,
                      ))
                  .toList(),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeEditor(
                    initialRecipe: null,
                    onEditFinished: Provider.of<RecipeStore>(context).addRecipe,
                    title: 'Add Recipe',
                  ),
            ),
          );
        },
      ),
    );
  }
}
