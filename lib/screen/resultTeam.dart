import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';

class ResultTeamScreen extends ConsumerWidget {
  const ResultTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: teamState.numberOfTeam,
          itemBuilder: (context, index) {
            return TeamResult(teamIndex: index);
          },
        ),
      ),
    );
  }
}

class TeamResult extends ConsumerWidget {
  const TeamResult({
    super.key,
    required this.teamIndex,
  });
  final int teamIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);
    final playersPerTeam = teamState.playerPerTeam;
    final startIndex = teamIndex * playersPerTeam;
    final endIndex = (teamIndex + 1) * playersPerTeam;
    final teamPlayers = teamState.players.sublist(
      startIndex,
      endIndex.clamp(0, teamState.players.length),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team ${teamIndex + 1}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...teamPlayers.map((player) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(player.name),
                      if (teamState.isDifferentRating)
                        Text(player.rating,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
