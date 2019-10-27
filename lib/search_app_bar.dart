import 'package:flutter/material.dart';

import 'app_localizations.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;
  final void Function() onBack;

  const SearchAppBar({Key key, this.onChanged, this.onBack}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: theme.colorScheme.onSurface,
        onPressed: () {
          if (onBack != null) {
            onBack();
          }
        },
      ),
      title: TextField(
        onChanged: onChanged,
        autofocus: true,
        cursorColor: theme.colorScheme.onSurface,
        decoration: InputDecoration(
          labelText: null,
          hintText: AppLocalizations.of(context).search,
          border: InputBorder.none,
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
    );
  }
}
