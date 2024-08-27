import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomNumbers {
  // properties of the class RandomNumbers
  final int minimumNumber;
  final int maxmumNumber;
  final int numberOfResult;
  final List<int> resultList; // Create an empty list of integers
  RandomNumbers({
    this.minimumNumber = 0,
    this.maxmumNumber = 10,
    this.numberOfResult = 1,
    List<int>? resultList, // Nullable list parameter
  }) : resultList = resultList ?? []; // Initialize with an empty list if null

// copyWith is method used to create new RandomNumbers instance with potentially modified values
//This method is commonly used in immutable classes to create new instances with updated values.
  RandomNumbers copyWith({
    //it takes two optinal properties
    int? minimumNumber,
    int? maxmumNumber,
    int? numberOfResult,
    List<int>? resultList,
  }) {
    //creating a new constructor
    return RandomNumbers(
      minimumNumber: minimumNumber ?? this.minimumNumber,
      maxmumNumber: maxmumNumber ?? this.maxmumNumber,
      numberOfResult: numberOfResult ?? this.numberOfResult,
      resultList: resultList ?? this.resultList,
    );
  }
}

class RanomNumberNotifier extends StateNotifier<RandomNumbers> {
  RanomNumberNotifier() : super(RandomNumbers());

  void minNumberIncrease(int count) {
    //make sure that the min number dosen't exceed the maxNumber
    if (state.maxmumNumber <= count) {
      state = state.copyWith(minimumNumber: count - 1);
    } else {
      state = state.copyWith(
        minimumNumber: count,
      );
    }
  }

  void maxNumberIncrease(int count) {
    if (state.minimumNumber >= count) {
      state = state.copyWith(maxmumNumber: count + 1);
    } else {
      state = state.copyWith(
        maxmumNumber: count,
      );
    }
  }

  void numberOfResult(int count) {
    state = state.copyWith(numberOfResult: count);
  }

  void generateRandomResult() {
    final List<int> finalResult = [];
    final Random _random = Random();

    while (finalResult.length < state.numberOfResult) {
//nextInt(6 - 4 + 1) nextInt(3) let's see the randomNumber is 2 + min(4) this is 6
      int randomNumber =
          _random.nextInt(state.maxmumNumber - state.minimumNumber + 1) +
              state.minimumNumber;

      // : Ensure no duplicates
      if (!finalResult.contains(randomNumber)) {
        finalResult.add(randomNumber);
      }
    }

    print(finalResult);
    state = state.copyWith(resultList: finalResult);
  }
}

final ranomNumberProvider =
    StateNotifierProvider<RanomNumberNotifier, RandomNumbers>((ref) {
  return RanomNumberNotifier();
});
