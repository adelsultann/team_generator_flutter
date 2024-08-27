import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:team_generator/providers/team_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerPerTeam extends ConsumerWidget {
  const PlayerPerTeam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.playerPerTeam,
                  style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => ref
                        .read(teamProvider.notifier)
                        .setPlayersPerTeam(teamState.playerPerTeam > 1
                            ? teamState.playerPerTeam - 1
                            : 1),
                  ),
                  Text('${teamState.playerPerTeam}',
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => ref
                        .read(teamProvider.notifier)
                        .setPlayersPerTeam(teamState.playerPerTeam < 10
                            ? teamState.playerPerTeam + 1
                            : 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
