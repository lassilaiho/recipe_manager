import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  final String localeName;

  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);
    return AppLocalizations(localeName);
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title => Intl.message(
        'Recipes',
        name: 'title',
        locale: localeName,
      );

  String get edit => Intl.message(
        'Edit',
        name: 'edit',
        locale: localeName,
      );

  String get remove => Intl.message(
        'Remove',
        name: 'remove',
        locale: localeName,
      );

  String get detailsTitle => Intl.message(
        'Recipe Details',
        name: 'detailsTitle',
        locale: localeName,
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        locale: localeName,
      );

  String get ingredients => Intl.message(
        'Ingredients',
        name: 'ingredients',
        locale: localeName,
      );

  String get steps => Intl.message(
        'Steps',
        name: 'steps',
        locale: localeName,
      );

  String get recipeDeleted => Intl.message(
        'Recipe deleted',
        name: 'recipeDeleted',
        locale: localeName,
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        locale: localeName,
      );

  String get editRecipe => Intl.message(
        'Edit Recipe',
        name: 'editRecipe',
        locale: localeName,
      );

  String get saveChanges => Intl.message(
        'Save Changes',
        name: 'saveChanges',
        locale: localeName,
      );

  String get name => Intl.message(
        'Name',
        name: 'name',
        locale: localeName,
      );

  String get description => Intl.message(
        'Description',
        name: 'description',
        locale: localeName,
      );

  String get addRecipe => Intl.message(
        'Add Recipe',
        name: 'addRecipe',
        locale: localeName,
      );

  String get recipesTitle {
    return Intl.message(
      'Recipes',
      name: 'recipesTitle',
      locale: localeName,
    );
  }

  String get search => Intl.message(
        'Search',
        name: 'search',
        locale: localeName,
      );

  String get unnamedRecipe => Intl.message(
        'Unnamed recipe',
        name: 'unnamedRecipe',
        locale: localeName,
      );

  String get copyIngredients => Intl.message(
        'Copy ingredients',
        name: 'copyIngredients',
        locale: localeName,
      );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
