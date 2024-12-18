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
          solveA(r'''
AAAA
BBCD
BBCC
EEEC
'''
              .toLinesList()),
          equals(140));
    });
    test('Example 2', () {
      expect(
          solveA(r'''
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
'''
              .toLinesList()),
          equals(772));
    });
    test('Example 3', () {
      expect(
          solveA(r'''
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
              .toLinesList()),
          equals(1930));
    });
    test('Solution', () {
      expect(solveA(input), equals(1387004));
    });
  });
}
