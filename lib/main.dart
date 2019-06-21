import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe.dart';
import 'recipe_view.dart';

const databaseName = 'data.db';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => RecipeStore(databaseName),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink,
      ),
      home: RecipeView(),
    );
  }
}
