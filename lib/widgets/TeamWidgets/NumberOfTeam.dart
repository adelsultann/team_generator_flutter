import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:team_generator/providers/team_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberOfTeam extends ConsumerWidget {
  const NumberOfTeam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context)!.numberOfTeam,
              style: TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => ref
                    .read(teamProvider.notifier)
                    .setNumberOfTeams(teamState.numberOfTeam > 1
                        ? teamState.numberOfTeam - 1
                        : 1),
              ),
              Text('${teamState.numberOfTeam}',
                  style: const TextStyle(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => ref
                    .read(teamProvider.notifier)
                    .setNumberOfTeams(teamState.numberOfTeam < 10
                        ? teamState.numberOfTeam + 1
                        : 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
