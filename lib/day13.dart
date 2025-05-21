// --- Day 13: Claw Contraption ---
// https://adventofcode.com/2024/day/13

import 'package:collection/collection.dart';

final buttonRegExp = RegExp(r'X\+(\d+), Y\+(\d+)');
final prizeRegExp = RegExp(r'X=(\d+), Y=(\d+)');

const costAButton = 3;
const costBButton = 1;

int solveA(Iterable<String> input) => solve(input, partB: false);
int solveB(Iterable<String> input) => solve(input, partB: true);

int solve(Iterable<String> input, {required bool partB}) {
  var sum = 0;

  for (final chunk
      in input
          .where((line) => line.isNotEmpty)
          .splitBefore((line) => line.startsWith('Button A:'))) {
    final [ax, ay] = [
      ...buttonRegExp
          .firstMatch(chunk[0])!
          .groups(const [1, 2])
          .map((s) => int.parse(s!)),
    ];
    final [bx, by] = [
      ...buttonRegExp
          .firstMatch(chunk[1])!
          .groups(const [1, 2])
          .map((s) => int.parse(s!)),
    ];
    final [px, py] = [
      ...prizeRegExp
          .firstMatch(chunk[2])!
          .groups(const [1, 2])
          .map((s) => int.parse(s!) + (partB ? 10000000000000 : 0)),
    ];

    final aButton = ((by * px) - (bx * py)) / ((ax * by) - (ay * bx));
    final bButton = ((ax * py) - (ay * px)) / ((ax * by) - (ay * bx));

    if (aButton > 0 &&
        bButton > 0 &&
        (aButton % 1) == 0 && // Checking if double values are whole
        (bButton % 1) == 0 &&
        (partB || (aButton <= 100 && bButton <= 100))) {
      sum += (aButton.toInt() * costAButton) + (bButton.toInt() * costBButton);
    }
  }

  return sum;
}
