// --- Day 13: Claw Contraption ---
// https://adventofcode.com/2024/day/13

import 'dart:math';

import 'package:collection/collection.dart';

final buttonRegExp = RegExp(r'X\+(\d+), Y\+(\d+)');
final prizeRegExp = RegExp(r'X=(\d+), Y=(\d+)');

const costAButton = 3;
const costBButton = 1;

int solveA(Iterable<String> input) {
  var sum = 0;

  for (final chunk in input
      .where((line) => line.isNotEmpty)
      .splitBefore((line) => line.startsWith('Button A:'))) {
    final [ax, ay] = [
      ...buttonRegExp
          .firstMatch(chunk[0])!
          .groups(const [1, 2]).map((s) => int.parse(s!))
    ];
    final [bx, by] = [
      ...buttonRegExp
          .firstMatch(chunk[1])!
          .groups(const [1, 2]).map((s) => int.parse(s!))
    ];
    final [px, py] = [
      ...prizeRegExp
          .firstMatch(chunk[2])!
          .groups(const [1, 2]).map((s) => int.parse(s!))
    ];

    var cost = 0;
    for (var a = 1; a <= 100; a++) {
      for (var b = 1; b <= 100; b++) {
        if ((a * ax) + (b * bx) == px && (a * ay) + (b * by) == py) {
          if (cost == 0) {
            cost = (a * costAButton) + (b * costBButton);
          } else {
            cost = min(cost, (a * costAButton) + (b * costBButton));
          }
        }
      }
    }

    sum += cost;
  }

  return sum;
}
