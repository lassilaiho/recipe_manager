import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;
  final void Function() onBack;

  const SearchAppBar({this.onChanged, this.onBack});

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
        decoration: const InputDecoration(
          labelText: null,
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
    );
  }
}
