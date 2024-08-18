import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/theme_providers.dart';
import 'package:team_generator/screen/team.dart';
import 'package:team_generator/widgets/mainItem.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator app'),
        actions: [
          const Text("Mode"),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
              ref.read(themeProvider.notifier).setTheme(newThemeMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          MainItem(
            text: "Team",
            imagePath: 'assets/images/team.png',
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TeamScreen()),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          MainItem(
            text: "random Number",
            imagePath: 'assets/images/team.png',
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TeamScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
