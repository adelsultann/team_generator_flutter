import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';
import 'package:team_generator/screen/team_screen/resultTeam.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TeamInputsScreen extends ConsumerWidget {
  const TeamInputsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.playerInputs),
      ),
      body: ListView.builder(
        itemCount: teamState.numberOfPlayers,
        itemBuilder: (context, index) {
          return PlayerInputCard(playerIndex: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.watch(teamProvider).numberOfTeam;
          ref.watch(teamProvider).numberOfPlayers;
          ref.watch(teamProvider).playerPerTeam;

          final teamState = ref.read(teamProvider);
          if (teamState.players.any((player) => player.name.isEmpty)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                AppLocalizations.of(context)!.wearningMessage,
              )),
            );
          } else {
            // Generate teams and navigate
            ref.read(teamProvider.notifier).generateTeams();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResultTeamScreen()),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class PlayerInputCard extends ConsumerStatefulWidget {
  const PlayerInputCard({
    super.key,
    required this.playerIndex,
  });

  final int playerIndex;

  @override
  _PlayerInputCardState createState() => _PlayerInputCardState();
}

class _PlayerInputCardState extends ConsumerState<PlayerInputCard> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamState = ref.watch(teamProvider);
    final isDifferentRating = teamState.isDifferentRating;
    //If the condition is true  the index is valid
    //return the player at that index
    final player = widget.playerIndex < teamState.players.length
        ? teamState.players[widget.playerIndex]
        // if not use the Player object and create new Player
        : Player(name: '', rating: 'Fair');

    if (_nameController.text != player.name) {
      _nameController.text = player.name;
    }

    String getLocalizedRating(BuildContext context, String rating) {
      switch (rating) {
        case 'Excellent':
          return AppLocalizations.of(context)!.excellent;
        case 'Good':
          return AppLocalizations.of(context)!.good;
        case 'Fair':
          return AppLocalizations.of(context)!.fair;
        default:
          return AppLocalizations.of(context)!.fair;
      }
    }

    String getNonLocalizedRating(BuildContext context, String localizedRating) {
      if (localizedRating == AppLocalizations.of(context)!.excellent)
        return 'Excellent';
      if (localizedRating == AppLocalizations.of(context)!.good) return 'Good';
      return 'Fair';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Text(
                '${widget.playerIndex + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _nameController,
                onChanged: (value) {
                  ref
                      .read(teamProvider.notifier)
                      .updatePlayerName(widget.playerIndex, value);
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.playerName,
                ),
              ),
            ),
            if (isDifferentRating) ...[
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: getLocalizedRating(context, player.rating),
                isDense: true,
                items: ['Excellent', 'Good', 'Fair'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: getLocalizedRating(context, value),
                    child: Text(getLocalizedRating(context, value)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(teamProvider.notifier).updatePlayerRating(
                        widget.playerIndex,
                        getNonLocalizedRating(context, newValue));
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
