import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';

const List<Widget> _toggleButtonsSelection = <Widget>[
  Text('Different'),
  Text('Same'),
];

class PlayerRating extends ConsumerWidget {
  const PlayerRating({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);
    final isDifferentRating = teamState.isDifferentRating;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Player Rating",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              ref.read(teamProvider.notifier).toggleRating();
              print("Toggle pressed. isDifferentRating: ${!isDifferentRating}");
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.blue[700],
            selectedColor: Colors.white,
            fillColor: Colors.blue[200],
            color: Colors.blue[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: [isDifferentRating, !isDifferentRating],
            children: _toggleButtonsSelection,
          ),
        ],
      ),
    );
  }
}
