#!/bin/bash
flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/app_localizations.dart
flutter pub run intl_translation:generate_from_arb `
    --output-dir=lib/l10n --no-use-deferred-loading `
    lib/app_localizations.dart (Get-ChildItem lib/l10n -Filter intl_*.arb).FullName
