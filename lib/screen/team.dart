import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/screen/team_inputs.dart';

import 'package:team_generator/widgets/TeamWidgets/NumberOfTeam.dart';
import 'package:team_generator/widgets/TeamWidgets/PlayerCountSelector.dart';
import 'package:team_generator/widgets/TeamWidgets/PlayerPerTeam.dart';
import 'package:team_generator/widgets/TeamWidgets/playerrating.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PlayerCountSelector(),
            PlayerRating(),
            NumberOfTeam(),
            PlayerPerTeam(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamInputsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
