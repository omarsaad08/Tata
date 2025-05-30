import 'package:flutter/widgets.dart';
import 'package:tata/app_localizations.dart';

extension TranslationExtension on BuildContext {
  String tr(String key, {String fallback = ''}) {
    return AppLocalizations.of(this).translate(key) ?? fallback;
  }
}
