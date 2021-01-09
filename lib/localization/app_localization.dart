import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  String _pathToLangResources = "lib/localization/lang";

  Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonObject = await rootBundle.loadString(
        "$_pathToLangResources/localization_${locale.languageCode}.json");
    Map<String, dynamic> localizedValues = jsonDecode(jsonObject);
    _localizedValues =
        localizedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String localized(String key) {
    return _localizedValues[key] ?? "$key key not found";
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ru"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    var appLocalization = AppLocalization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
