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
  State<StatefulWidget> createState() => _RecipeEditorState();
}

class _RecipeEditorState extends State<RecipeEditor> {
  var _name = '';
  var _description = '';
  var _ingredients = '';
  var _steps = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialRecipe != null) {
      _name = widget.initialRecipe.name;
      _description = widget.initialRecipe.description;
      _ingredients = widget.initialRecipe.ingredients.join('\n');
      _steps = widget.initialRecipe.steps;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                initialValue: _name,
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Description'),
                initialValue: _description,
                onSaved: (value) => _description = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Ingredients'),
                initialValue: _ingredients,
                onSaved: (value) => _ingredients = value,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Steps'),
                initialValue: _steps,
                onSaved: (value) => _steps = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (widget.onEditFinished != null) {
      _formKey.currentState.save();
      widget.onEditFinished(Recipe(
        id: widget.initialRecipe?.id ?? -1,
        name: _name,
        description: _description,
        ingredients: _ingredients.isEmpty ? [] : _ingredients.split('\n'),
        steps: _steps,
      ));
    }
    Navigator.pop(context);
  }
}
