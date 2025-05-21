// --- Day 12: Garden Groups ---
// https://adventofcode.com/2024/day/12

import 'dart:io';
import 'package:advent_of_code_2024/day12.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day12.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
AAAA
BBCD
BBCC
EEEC
'''
              .toLinesList(),
        ),
        equals(140),
      );
    });
    test('Example 2', () {
      expect(
        solveA(
          r'''
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
'''
              .toLinesList(),
        ),
        equals(772),
      );
    });
    test('Example 3', () {
      expect(
        solveA(
          r'''
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
'''
              .toLinesList(),
        ),
        equals(1930),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(1387004));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(
          r'''
AAAA
BBCD
BBCC
EEEC
'''
              .toLinesList(),
        ),
        equals(80),
      );
    });
    test('Example 2', () {
      expect(
        solveB(
          r'''
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
'''
              .toLinesList(),
        ),
        equals(436),
      );
    });
    test('Example 3', () {
      expect(
        solveB(
          r'''
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
'''
              .toLinesList(),
        ),
        equals(236),
      );
    });
    test('Example 4', () {
      expect(
        solveB(
          r'''
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
'''
              .toLinesList(),
        ),
        equals(368),
      );
    });
    test('Example 5', () {
      expect(
        solveB(
          r'''
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
'''
              .toLinesList(),
        ),
        equals(1206),
      );
    });
    test('Solution', () {
      expect(solveB(input), equals(844198));
    });
  });
}
