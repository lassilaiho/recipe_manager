import 'package:flutter/material.dart';

import 'recipe.dart';

class RecipeEditor extends StatefulWidget {
  final Recipe initialRecipe;
  final void Function(Recipe recipe) onEditFinished;
  final String title;

  const RecipeEditor({
    Key key,
    this.initialRecipe,
    this.onEditFinished,
    this.title = 'Edit Recipe',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _RecipeEditorState(initialRecipe, onEditFinished, title);
}

class _RecipeEditorState extends State<RecipeEditor> {
  final Recipe initialRecipe;
  final void Function(Recipe) onEditFinished;
  final String title;

  var name = '';
  var description = '';
  var ingredients = '';
  var steps = '';

  final _formKey = GlobalKey<FormState>();

  _RecipeEditorState(this.initialRecipe, this.onEditFinished, this.title);

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
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Save Changes',
            onPressed: _saveChanges,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
        ingredients: ingredients.isEmpty ? [] : ingredients.split('\n'),
        steps: steps,
      ));
    }
    Navigator.pop(context);
  }
}
