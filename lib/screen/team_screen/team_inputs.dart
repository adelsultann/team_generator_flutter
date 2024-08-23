import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';
import 'package:team_generator/screen/team_screen/resultTeam.dart';

class TeamInputsScreen extends ConsumerWidget {
  const TeamInputsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Inputs'),
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
              const SnackBar(
                  content: Text('Please enter names for all players')),
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
    print("isDifferentRating: $isDifferentRating");

// Safely access the player, or create a default one if it doesn't exist
    final player = widget.playerIndex < teamState.players.length
//if true we will retained the existing player at that index
        ? teamState.players[widget.playerIndex]
// if false we will create new player objects
        : Player(name: '', rating: 'Fair');

// Update the controller text if it's different from the player's name
    if (_nameController.text != player.name) {
      _nameController.text = player.name;
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
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: InputBorder.none,
                  hintText: 'Player Name',
                ),
              ),
            ),
            if (isDifferentRating) ...[
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: player.rating,
                isDense: true,
                items: ['Excellent', 'Good', 'Fair'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value), // Use only the first letter
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref
                        .read(teamProvider.notifier)
                        .updatePlayerRating(widget.playerIndex, newValue);
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
