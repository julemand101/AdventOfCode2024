// --- Day 3: Mull It Over ---
// https://adventofcode.com/2024/day/3

import 'dart:io';
import 'package:advent_of_code_2024/day03.dart';
import 'package:test/test.dart';

final input = File('test/data/day03.txt').readAsStringSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(r'''
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
'''), equals(161));
    });
    test('Solution', () {
      expect(solveA(input), equals(173731097));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(r'''
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
'''), equals(48));
    });
    test('Solution', () {
      expect(solveB(input), equals(93729253));
    });
  });
}
