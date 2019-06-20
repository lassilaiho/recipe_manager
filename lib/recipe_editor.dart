import 'package:flutter/material.dart';

import 'recipe.dart';

class RecipeEditor extends StatefulWidget {
  final Recipe initialRecipe;
  final void Function(Recipe recipe) onEditFinished;

  const RecipeEditor({this.initialRecipe, this.onEditFinished});

  @override
  State<StatefulWidget> createState() =>
      _RecipeEditorState(initialRecipe, onEditFinished);
}

class _RecipeEditorState extends State<RecipeEditor> {
  final Recipe initialRecipe;
  final void Function(Recipe) onEditFinished;

  String name;
  String description;
  String ingredients;
  String steps;

  final _formKey = GlobalKey<FormState>();

  _RecipeEditorState(this.initialRecipe, this.onEditFinished);

  @override
  void initState() {
    super.initState();
    if (initialRecipe != null) {
      name = initialRecipe.name;
      description = initialRecipe.description;
      ingredients = initialRecipe.ingredients.join('\n');
      steps = initialRecipe.steps;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Save Changes',
            onPressed: _saveChanges,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: name,
                onSaved: (value) => name = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Description'),
                initialValue: description,
                onSaved: (value) => description = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Ingredients'),
                initialValue: ingredients,
                onSaved: (value) => ingredients = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Steps'),
                initialValue: steps,
                onSaved: (value) => steps = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (onEditFinished != null) {
      _formKey.currentState.save();
      onEditFinished(Recipe(
        id: initialRecipe?.id ?? -1,
        name: name,
        description: description,
        ingredients: ingredients.split('\n'),
        steps: steps,
      ));
    }
    Navigator.pop(context);
  }
}
