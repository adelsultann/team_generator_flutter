import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Language {
  final String code;
  final String name;

  Language(this.code, this.name);
}

class LanguageState {
  final Locale locale;
  final List<Language> supportedLanguages;

  LanguageState({required this.locale, required this.supportedLanguages});

  LanguageState copyWith({Locale? locale}) {
    return LanguageState(
        locale: locale ?? this.locale, supportedLanguages: supportedLanguages);
  }
}

class LanguageNotifier extends StateNotifier<LanguageState> {
  LanguageNotifier()
      : super(LanguageState(locale: Locale('en', ''), supportedLanguages: [
          Language('en', 'English'),
          Language('ar', 'العربية'),
          Language('es', 'Spanish'),
          Language('tr', 'Turkish'),

          // Add more languages here
        ]));

  void setLanguage(String languageCode) {
    state = state.copyWith(locale: Locale(languageCode, ''));
  }
}

final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
  return LanguageNotifier();
});
