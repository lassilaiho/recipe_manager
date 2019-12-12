// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addRecipe" : MessageLookupByLibrary.simpleMessage("Add Recipe"),
    "copyIngredients" : MessageLookupByLibrary.simpleMessage("Copy ingredients"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "detailsTitle" : MessageLookupByLibrary.simpleMessage("Recipe Details"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editRecipe" : MessageLookupByLibrary.simpleMessage("Edit Recipe"),
    "ingredients" : MessageLookupByLibrary.simpleMessage("Ingredients"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "recipeDeleted" : MessageLookupByLibrary.simpleMessage("Recipe deleted"),
    "recipesTitle" : MessageLookupByLibrary.simpleMessage("Recipes"),
    "remove" : MessageLookupByLibrary.simpleMessage("Remove"),
    "saveChanges" : MessageLookupByLibrary.simpleMessage("Save Changes"),
    "search" : MessageLookupByLibrary.simpleMessage("Search"),
    "steps" : MessageLookupByLibrary.simpleMessage("Steps"),
    "title" : MessageLookupByLibrary.simpleMessage("Recipes"),
    "undo" : MessageLookupByLibrary.simpleMessage("Undo"),
    "unnamedRecipe" : MessageLookupByLibrary.simpleMessage("Unnamed recipe")
  };
}
