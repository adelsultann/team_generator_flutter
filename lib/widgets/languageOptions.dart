import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/language_provider.dart';

class LanguageDropdown extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageProvider);

    return DropdownButton<String>(
      value: languageState.locale.languageCode,
      items: languageState.supportedLanguages.map((Language language) {
        return DropdownMenuItem<String>(
          value: language.code,
          child: Text(language.name),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          ref.read(languageProvider.notifier).setLanguage(newValue);
        }
      },
    );
  }
}
