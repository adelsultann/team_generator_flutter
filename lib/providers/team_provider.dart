import 'package:flutter_riverpod/flutter_riverpod.dart';

//The Player class represents an individual player, with fields for name and rating
class Player {
  final String name;
  final String rating;

  Player({
    required this.name,
    required this.rating,
  });

//copyWith Method: This method allows creating a copy of a Player object with some fields modified. If no new value is provided for a field

  Player copyWith({
    String? name,
    String? rating,
  }) {
    return Player(
      // this ?? mean if the left side is null use the right side
      name: name ?? this.name,
      rating: rating ?? this.rating,
    );
  }
}

//TeamState is a class that holds the state of the team settings and their types
//benefit of creating class like this | immutablity |Encapsulation| grouped togather
// | Type Safety you get compile-time type checking |
class TeamState {
  final int numberOfPlayers;
  final bool isDifferentRating;
  final int numberOfTeam;
  final int playerPerTeam;
  final List<Player> players;

//Default Values: Default values are provided for each field, ensuring the state is always initialized with meaningful values.
  TeamState({
    this.numberOfPlayers = 2,
    this.isDifferentRating = true,
    this.numberOfTeam = 2,
    this.playerPerTeam = 2,
    // if a list of player ins't provided the player list is initalized with
    //player object with an empty name and fair rating
    List<Player>? players,
  }) : players = players ??
            List.generate(
                numberOfPlayers, (_) => Player(name: '', rating: 'Fair'));

//copyWith method is a powerful feature in Dart that allows the user to create a new object by copying existing data and modifying selected fields
//useful when dealing with immutable classes

  TeamState copyWith({
    int? numberOfPlayers,
    bool? isDifferentRating,
    int? numberOfTeam,
    int? playerPerTeam,
    List<Player>? players,
  }) {
    return TeamState(
      // The copyWith method takes the final string name as an argument and returns a new User object. If a null value is passed, the method will use the current name value.
      numberOfPlayers: numberOfPlayers ?? this.numberOfPlayers,
      isDifferentRating: isDifferentRating ?? this.isDifferentRating,
      numberOfTeam: numberOfTeam ?? this.numberOfTeam,
      playerPerTeam: playerPerTeam ?? this.playerPerTeam,
      players: players ?? this.players,
    );
  }
}

class TeamNotifier extends StateNotifier<TeamState> {
  //The constructor initializes the state with the default values defined in TeamState
  TeamNotifier() : super(TeamState());

  void setNumberOfPlayers(int count) {
    state = state.copyWith(
      numberOfPlayers: count,

      //List.generate is built in function on dart
      players: List.generate(
        count,
        //the generater function take index
        (index) => index < state.players.length

            //if true we will retained the existing player at their index
            ? state.players[index]
            // if false we will create new player objects
            : Player(name: '', rating: 'Fair'),
      ),
    );
  }

  void toggleRating() {
    print("Toggling rating. Current: ${state.isDifferentRating}");
    state = state.copyWith(isDifferentRating: !state.isDifferentRating);
    print("After toggle: ${state.isDifferentRating}");
  }

  void setNumberOfTeams(int count) {
    state = state.copyWith(
      numberOfTeam: count,
      playerPerTeam: (state.numberOfPlayers / count).ceil(),
    );
  }

  void setPlayersPerTeam(int count) {
    state = state.copyWith(
      playerPerTeam: count,
      numberOfTeam: (state.numberOfPlayers / count).ceil(),
    );
  }

  void updatePlayerName(int index, String name) {
    final updatedPlayers = [...state.players];
    updatedPlayers[index] = updatedPlayers[index].copyWith(name: name);
    state = state.copyWith(players: updatedPlayers);
  }

  void updatePlayerRating(int index, String rating) {
    final updatedPlayers = [...state.players];
    updatedPlayers[index] = updatedPlayers[index].copyWith(rating: rating);
    state = state.copyWith(players: updatedPlayers);
  }

  void generateTeams() {
    List<Player> allPlayers = List.from(state.players);
    int numberOfTeams = state.numberOfTeam;

    // Sort players by skill level in ascending order
    allPlayers.sort(
        (a, b) => _getSkillValue(a.rating).compareTo(_getSkillValue(b.rating)));

    // Create an array of teams, each team initially empty
    List<List<Player>> teams = List.generate(numberOfTeams, (_) => []);

    // Distribute players among teams
    for (int i = 0; i < allPlayers.length; i++) {
      int teamIndex = i % numberOfTeams;
      teams[teamIndex].add(allPlayers[i]);
    }

    // Flatten the teams list
    List<Player> distributedPlayers = teams.expand((team) => team).toList();

    // Update the state
    state = state.copyWith(
      players: distributedPlayers,
      numberOfTeam: teams.length,
      playerPerTeam: teams.isNotEmpty ? teams[0].length : 0,
    );

    // Print teams for debugging
    for (int i = 0; i < teams.length; i++) {
      print('Team ${i + 1}:');
      for (var player in teams[i]) {
        print(
            '  ${player.name} - ${player.rating} (${_getSkillValue(player.rating)})');
      }
      print(
          '  Total Skill: ${teams[i].map((p) => _getSkillValue(p.rating)).reduce((a, b) => a + b)}');
    }
  }

  int _getSkillValue(String rating) {
    switch (rating) {
      case 'Excellent':
        return 3;
      case 'Good':
        return 2;
      case 'Fair':
        return 1;
      default:
        return 0;
    }
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, TeamState>((ref) {
  return TeamNotifier();
});
