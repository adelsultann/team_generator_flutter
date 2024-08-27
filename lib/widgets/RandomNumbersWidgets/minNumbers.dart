import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/randomNumbers_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MinNumber extends ConsumerWidget {
  const MinNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(ranomNumberProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.minumiumNumbers,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).minNumberIncrease(
                      numberState.minimumNumber > 0
                          ? numberState.minimumNumber - 1
                          : 0),
                },
              ),
              Text(
                '${numberState.minimumNumber}',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).minNumberIncrease(
                      numberState.minimumNumber < 100
                          ? numberState.minimumNumber + 1
                          : 100),
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
