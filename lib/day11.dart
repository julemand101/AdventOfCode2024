// --- Day 11: Plutonian Pebbles ---
// https://adventofcode.com/2024/day/11

import 'dart:collection';

final class Stone extends LinkedListEntry<Stone> {
  int value;

  Stone(this.value);
}

int solveA(String input, {int blink = 25}) => solve(input, blink: blink);
int solveB(String input) => solve(input, blink: 75);

int solve(String input, {int blink = 25}) {
  final stones = LinkedList<Stone>();

  for (final stoneValue in input.split(' ').map(int.parse)) {
    stones.add(Stone(stoneValue));
  }

  for (var i = 0; i < blink; i++) {
    Stone? stone = stones.first;

    while (stone != null) {
      if (stone.value == 0) {
        stone.value = 1;
      } else if (stone.value.toString() case final numberString
          when numberString.length % 2 == 0) {
        stone.insertBefore(Stone(
            int.parse(numberString.substring(0, numberString.length ~/ 2))));
        stone.value =
            int.parse(numberString.substring(numberString.length ~/ 2));
      } else {
        stone.value *= 2024;
      }

      stone = stone.next;
    }
  }

  return stones.length;
}
