import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
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
    final localizations = AppLocalizations.of(context);
    return MaterialApp(
      title: localizations?.title ?? 'Recipe Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink,
      ),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fi'),
      ],
      home: RecipeView(),
    );
  }
}
