import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';
import 'package:team_generator/screen/resultTeam.dart';

class TeamInputsScreen extends ConsumerWidget {
  const TeamInputsScreen({super.key});

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
          // Generate teams
          ref.read(teamProvider.notifier).generateTeams();
// Access the updated state after generating teams
          final updatedState = ref.read(teamProvider);

          // Print generated teams
          print('Generated Teams:');
          for (int i = 0; i < updatedState.numberOfTeam; i++) {
            print('Team ${i + 1}:');
            final startIndex = i * updatedState.playerPerTeam;
            final endIndex = (i + 1) * updatedState.playerPerTeam;
            final teamPlayers = updatedState.players.sublist(
              startIndex,
              endIndex.clamp(0, updatedState.players.length),
            );
            for (final player in teamPlayers) {
              print('  Name: ${player.name}, Rating: ${player.rating}');
            }
          }
          // Print players for debugging
          print(teamState.players);

          // Navigate to ResultTeamScreen
          print(teamState.players);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ResultTeamScreen()));
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('${widget.playerIndex + 1}'),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _nameController,
                onChanged: (value) {
                  ref
                      .read(teamProvider.notifier)
                      .updatePlayerName(widget.playerIndex, value);
                },
                decoration: const InputDecoration(labelText: 'Player Name'),
              ),
            ),
            // if the rating is set to different we will render this
            if (isDifferentRating) ...[
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: player.rating,
                items: ['Excellent', 'Good', 'Fair'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
