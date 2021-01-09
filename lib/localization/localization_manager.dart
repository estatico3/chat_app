import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalizationManager {
  Stream<Locale> getLocaleStream();

  void setLocale(Locale locale);
}

class AppLocalizationManager implements LocalizationManager {
  BehaviorSubject<Locale> _localesSubject = BehaviorSubject();

  String _langKey = "lang_key";

  String _defaultLanguage = "en";

  AppLocalizationManager() {
    _initLocale();
  }

  void _initLocale() async {
    String _localeLangCode =
        (await SharedPreferences.getInstance()).getString(_langKey);
    if (_localeLangCode == null) {
      await _setDefaultLocalization();
    }
    _localesSubject.add(Locale(_localeLangCode));
  }

  @override
  void setLocale(Locale locale) async {
    (await SharedPreferences.getInstance())
        .setString(_langKey, locale.languageCode);
    _localesSubject.add(locale);
  }

  @override
  Stream<Locale> getLocaleStream() {
    return _localesSubject.stream;
  }

  Future<void> _setDefaultLocalization() async {
    (await SharedPreferences.getInstance())
        .setString(_langKey, _defaultLanguage);
  }
}
