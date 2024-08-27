import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:team_generator/providers/language_provider.dart';
import 'package:team_generator/providers/theme_providers.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final languageState = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.darkMode),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
                ref.read(themeProvider.notifier).setTheme(newThemeMode);
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: DropdownButton<String>(
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
            ),
          ),
        ],
      ),
    );
  }
}
