import 'package:async/async.dart';
import 'package:flutter/material.dart';

const recipeDeletionUndoDuration = Duration(seconds: 5);

void showRecipeDeletionSnackBar(BuildContext context,
        CancelableOperation<void> operation, Duration duration) =>
    Scaffold.of(context).showSnackBar(SnackBar(
      content: const Text('Recipe deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => operation.cancel(),
      ),
      duration: duration,
    ));
