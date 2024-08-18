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
      numberOfTeam: (count / state.playerPerTeam).ceil(),
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
    List<Player> excellentPlayers = [];
    List<Player> goodPlayers = [];
    List<Player> fairPlayers = [];

    // Sort players into skill levels
    for (var player in state.players) {
      switch (player.rating) {
        case 'Excellent':
          excellentPlayers.add(player);
          break;
        case 'Good':
          goodPlayers.add(player);
          break;
        case 'Fair':
          fairPlayers.add(player);
          break;
      }
    }

    //this will create an empty list that will hold lists of players each inner list
    //repesent team

    List<List<Player>> teams = [];

    // Check for the specific case: 4 players, 2 good, 1 fair, 1 excellent
    if (state.players.length == 4 &&
        excellentPlayers.length == 1 &&
        goodPlayers.length == 2 &&
        fairPlayers.length == 1) {
      // Create two teams
      teams = [
        [excellentPlayers[0], fairPlayers[0]], // Team 1: Excellent + Fair
        [goodPlayers[0], goodPlayers[1]] // Team 2: Good + Good
      ];
    } else {
      // For all other cases, use the original distribution logic
      teams = List.generate(state.numberOfTeam, (_) => []);
      List<List<Player>> skillLevels = [
        excellentPlayers,
        goodPlayers,
        fairPlayers
      ];

      for (var skillLevel in skillLevels) {
        skillLevel.shuffle(); // Shuffle players within each skill level
        int teamIndex = 0;

        for (var player in skillLevel) {
          teams[teamIndex].add(player);
          //modulo operation. It gives us the remainder when dividing by the number of teams.
          teamIndex = (teamIndex + 1) % state.numberOfTeam;
        }
      }
    }

// explain the flattening
//    [
//   [Player1, Player2],
//   [Player3, Player4],
//   [Player5, Player6]
// ]
//becone [Player1, Player2, Player3, Player4, Player5, Player6]

// we did this because at the end state expect single list
    List<Player> distributedPlayers = teams.expand((team) => team).toList();

    // Update the state with the new player order and number of teams
    state = state.copyWith(
        players: distributedPlayers,
        numberOfTeam: teams.length,
        playerPerTeam: teams.isNotEmpty ? teams[0].length : 0);
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, TeamState>((ref) {
  return TeamNotifier();
});
