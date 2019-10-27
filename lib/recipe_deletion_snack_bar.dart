import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:recipe_manager/app_localizations.dart';

const recipeDeletionUndoDuration = Duration(seconds: 5);

class RecipeDeletionAction {
  final CancelableOperation<void> operation;
  final Duration duration;

  const RecipeDeletionAction(this.operation, this.duration);
}

void showRecipeDeletionSnackBar(BuildContext context,
    CancelableOperation<void> operation, Duration duration) {
  final localizations = AppLocalizations.of(context);
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(localizations.recipeDeleted),
      action: SnackBarAction(
        label: localizations.undo,
        onPressed: () => operation.cancel(),
      ),
      duration: duration,
    ));
}
