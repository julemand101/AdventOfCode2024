// --- Day 11: Plutonian Pebbles ---
// https://adventofcode.com/2024/day/11

import 'dart:io';
import 'package:advent_of_code_2024/day11.dart';
import 'package:test/test.dart';

final input = File('test/data/day11.txt').readAsLinesSync().first;

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA('0 1 10 99 999', blink: 1), equals(7));
    });
    test('Example 2', () {
      expect(solveA('125 17', blink: 1), equals(3));
    });
    test('Example 3', () {
      expect(solveA('125 17', blink: 6), equals(22));
    });
    test('Example 4', () {
      expect(solveA('125 17'), equals(55312));
    });
    test('Solution', () {
      expect(solveA(input), equals(193607));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(input), equals(-1));
    });
  }, skip: true);
}
