// --- Day 6: Guard Gallivant ---
// https://adventofcode.com/2024/day/6

import 'dart:io';
import 'package:advent_of_code_2024/day06.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day06.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
'''
              .toLinesList(),
        ),
        equals(41),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(4696));
    });
  });
  group('Part Two', () {
    test('Example 1', () async {
      expect(
        await solveB(
          r'''
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
'''
              .toLinesList(),
        ),
        equals(6),
      );
    });
    test('Solution', () async {
      expect(await solveB(input), equals(1443));
    });
  });
}
