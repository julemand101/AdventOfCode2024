// --- Day 2: Red-Nosed Reports ---
// https://adventofcode.com/2024/day/2

import 'dart:io';
import 'package:advent_of_code_2024/day02.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day02.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
'''
              .asLines,
        ),
        equals(2),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(421));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(
          r'''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
'''
              .asLines,
        ),
        equals(4),
      );
    });
    test('Solution', () {
      expect(solveB(input), equals(476));
    });
  });
}
