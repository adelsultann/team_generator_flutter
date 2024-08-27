import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/theme_providers.dart';
import 'package:team_generator/screen/numbers_screen/numbers.dart';
import 'package:team_generator/screen/password_screen/password_input_screen.dart';
import 'package:team_generator/screen/roulette_Screen/roulette_input_screen.dart';
import 'package:team_generator/screen/settings_screen.dart';
import 'package:team_generator/screen/team_screen/team.dart';
import 'package:team_generator/widgets/mainItem.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:team_generator/providers/language_provider.dart';

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blueGrey[900],
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.blueGrey[800]!,
    background: Colors.grey[900]!,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
  ),
);
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
    final languageState = ref.watch(languageProvider);

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: languageState.supportedLanguages
          .map((lang) => Locale(lang.code, ''))
          .toList(),
      locale: languageState.locale,
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
    final items = [
      {
        "textBuilder": (BuildContext context) =>
            AppLocalizations.of(context)!.team,
        "imagePath": 'assets/images/team.png',
        "gradient": const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TeamScreen()),
          );
        },
      },
      {
        "textBuilder": (BuildContext context) =>
            AppLocalizations.of(context)!.numbers,
        "imagePath": 'assets/images/numbers-ing.png',
        "gradient": const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NumbersScreen()),
          );
        },
      },
      {
        "textBuilder": (BuildContext context) =>
            AppLocalizations.of(context)!.rouletteWheel,
        "imagePath": 'assets/images/roulette-wheel.png',
        "gradient": const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RouletteInputScreen()),
          );
        },
      },
      {
        "textBuilder": (BuildContext context) =>
            AppLocalizations.of(context)!.generatePassword,
        "imagePath": 'assets/images/lock.png',
        "gradient": const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PasswordInputScreen()),
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: MainItem(
              textBuilder: item['textBuilder'] as String Function(BuildContext),
              imagePath: item['imagePath'] as String,
              gradient: item['gradient'] as Gradient,
              onTap: item['onTap'] as VoidCallback,
            ),
          );
        },
      ),
    );
  }
}



// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.appTitle),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           MainItem(
//             textBuilder: (context) => AppLocalizations.of(context)!.team,
//             imagePath: 'assets/images/team.png',
//             gradient: const LinearGradient(
//               colors: [Colors.purple, Colors.blue],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const TeamScreen()),
//               );
//             },
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           MainItem(
//             textBuilder: (context) => AppLocalizations.of(context)!.numbers,
//             imagePath: 'assets/images/numbers-ing.png',
//             gradient: const LinearGradient(
//               colors: [Colors.purple, Colors.blue],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const NumbersScreen()),
//               );
//             },
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           MainItem(
//             textBuilder: (context) =>
//                 AppLocalizations.of(context)!.rouletteWheel,
//             imagePath: 'assets/images/roulette-wheel.png',
//             gradient: const LinearGradient(
//               colors: [Colors.purple, Colors.blue],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const RouletteInputScreen()),
//               );
//             },
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           MainItem(
//             textBuilder: (context) =>
//                 AppLocalizations.of(context)!.generatePassword,
//             imagePath: 'assets/images/lock.png',
//             gradient: const LinearGradient(
//               colors: [Colors.purple, Colors.blue],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PasswordInputScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }