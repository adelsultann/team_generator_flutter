import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/randomNumbers_provider.dart';

class NumberOfReault extends ConsumerWidget {
  const NumberOfReault({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(ranomNumberProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Number Of Reault",
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).numberOfResult(
                      numberState.numberOfResult == 0
                          ? numberState.numberOfResult - 1
                          : 1),
                },
              ),
              Text(
                '${numberState.numberOfResult}',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => {
                  ref.read(ranomNumberProvider.notifier).numberOfResult(
                      numberState.numberOfResult < 15
                          ? numberState.numberOfResult + 1
                          : 15),
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
