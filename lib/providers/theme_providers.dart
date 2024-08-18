import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateNotifier for managing the theme
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  // Getter for the current theme mode
  ThemeMode get themeMode => state;

  // Method to set the theme mode
  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

// Create a provider for ThemeNotifier
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
