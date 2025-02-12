// --- Day 11: Plutonian Pebbles ---
// https://adventofcode.com/2024/day/11

import 'dart:collection';

import 'package:collection/collection.dart';

int solveA(String input, {int blink = 25}) => solve(input, blink: blink);
int solveB(String input) => solve(input, blink: 75);

int solve(String input, {int blink = 25}) {
  var currentStones = HashMap<int, int>();
  for (final stone in input.split(' ')) {
    currentStones.update(int.parse(stone), (v) => v + 1, ifAbsent: () => 1);
  }

  var nextStones = HashMap<int, int>();
  for (var i = 0; i < blink; i++) {
    for (final MapEntry(key: stone, value: amount) in currentStones.entries) {
      void addNextStone(int stone) =>
          nextStones.update(stone, (v) => v + amount, ifAbsent: () => amount);

      if (stone == 0) {
        addNextStone(1);
      } else if (stone.toString() case var string when string.length % 2 == 0) {
        addNextStone(int.parse(string.substring(0, string.length ~/ 2)));
        addNextStone(int.parse(string.substring(string.length ~/ 2)));
      } else {
        addNextStone(stone * 2024);
      }
    }

    (currentStones, nextStones) = (nextStones, currentStones..clear());
  }

  return currentStones.values.sum;
}
