import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';

class PlayerCountSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerCount = ref.watch(teamProvider).numberOfPlayers;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Number of Players", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => ref
                    .read(teamProvider.notifier)
                    .setNumberOfPlayers(playerCount > 2 ? playerCount - 1 : 2),
              ),
              Text('$playerCount', style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => ref
                    .read(teamProvider.notifier)
                    .setNumberOfPlayers(
                        playerCount < 20 ? playerCount + 1 : 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
