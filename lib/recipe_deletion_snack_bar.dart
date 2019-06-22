import 'package:async/async.dart';
import 'package:flutter/material.dart';

const recipeDeletionUndoDuration = Duration(seconds: 5);

class RecipeDeletionAction {
  final CancelableOperation<void> operation;
  final Duration duration;

  const RecipeDeletionAction(this.operation, this.duration);
}

void showRecipeDeletionSnackBar(BuildContext context,
        CancelableOperation<void> operation, Duration duration) =>
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: const Text('Recipe deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => operation.cancel(),
        ),
        duration: duration,
      ));
