// --- Day 14: Restroom Redoubt ---
// https://adventofcode.com/2024/day/14

import 'dart:io';
import 'package:advent_of_code_2024/day14.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day14.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(
            r'''
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
'''
                .asLines,
            wide: 11,
            tall: 7,
          ),
          equals(12));
    });
    test('Solution', () {
      expect(solveA(input), equals(226236192));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(input), equals(8168));
    });
  });
}
