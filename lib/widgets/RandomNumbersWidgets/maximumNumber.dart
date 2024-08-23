import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/randomNumbers_provider.dart';

class MaxNumber extends ConsumerWidget {
  const MaxNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(ranomNumberProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Maximum Number",
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).maxNumberIncrease(
                      numberState.maxmumNumber > 0
                          ? numberState.maxmumNumber - 1
                          : 0),
                },
              ),
              Text(
                '${numberState.maxmumNumber}',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).maxNumberIncrease(
                      numberState.maxmumNumber < 100
                          ? numberState.maxmumNumber + 1
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
