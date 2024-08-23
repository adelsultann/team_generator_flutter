import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/randomNumbers_provider.dart';
import 'package:team_generator/screen/numbers_screen/numberResult.dart';
import 'package:team_generator/widgets/RandomNumbersWidgets/NumberOfReault.dart';
import 'package:team_generator/widgets/RandomNumbersWidgets/maximumNumber.dart';
import 'package:team_generator/widgets/RandomNumbersWidgets/minNumbers.dart';

class NumbersScreen extends ConsumerWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(ranomNumberProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Numbers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const MinNumber(),
            const MaxNumber(),
            const NumberOfReault(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(ranomNumberProvider.notifier).generateRandomResult();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NumberResult()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}