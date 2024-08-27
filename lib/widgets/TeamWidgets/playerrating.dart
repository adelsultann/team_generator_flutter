import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/team_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerRating extends ConsumerWidget {
  const PlayerRating({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> toggleButtonsSelection = <Widget>[
      Text(AppLocalizations.of(context)!.different),
      Text(AppLocalizations.of(context)!.same),
    ];

    final teamState = ref.watch(teamProvider);
    final isDifferentRating = teamState.isDifferentRating;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.playerRating,
            style: const TextStyle(
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
            children: toggleButtonsSelection,
          ),
        ],
      ),
    );
  }
}
