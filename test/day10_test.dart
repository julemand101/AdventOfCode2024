// --- Day 10: Hoof It ---
// https://adventofcode.com/2024/day/10

import 'dart:io';
import 'package:advent_of_code_2024/day10.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day10.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
0123
1234
8765
9876
'''
              .toLinesList(),
        ),
        equals(1),
      );
    });
    test('Example 2', () {
      expect(
        solveA(
          r'''
...0...
...1...
...2...
6543456
7.....7
8.....8
9.....9
'''
              .toLinesList(),
        ),
        equals(2),
      );
    });
    test('Example 3', () {
      expect(
        solveA(
          r'''
..90..9
...1.98
...2..7
6543456
765.987
876....
987....
'''
              .toLinesList(),
        ),
        equals(4),
      );
    });
    test('Example 4', () {
      expect(
        solveA(
          r'''
10..9..
2...8..
3...7..
4567654
...8..3
...9..2
.....01
'''
              .toLinesList(),
        ),
        equals(3),
      );
    });
    test('Example 5', () {
      expect(
        solveA(
          r'''
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
'''
              .toLinesList(),
        ),
        equals(36),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(582));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(
          r'''
.....0.
..4321.
..5..2.
..6543.
..7..4.
..8765.
..9....
'''
              .toLinesList(),
        ),
        equals(3),
      );
    });
    test('Example 2', () {
      expect(
        solveB(
          r'''
..90..9
...1.98
...2..7
6543456
765.987
876....
987....
'''
              .toLinesList(),
        ),
        equals(13),
      );
    });
    test('Example 3', () {
      expect(
        solveB(
          r'''
012345
123456
234567
345678
4.6789
56789.
'''
              .toLinesList(),
        ),
        equals(227),
      );
    });
    test('Example 4', () {
      expect(
        solveB(
          r'''
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
'''
              .toLinesList(),
        ),
        equals(81),
      );
    });
    test('Solution', () {
      expect(solveB(input), equals(1302));
    });
  });
}
