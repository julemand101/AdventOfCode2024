// --- Day 7: Bridge Repair ---
// https://adventofcode.com/2024/day/7

import 'dart:io';
import 'package:advent_of_code_2024/day07.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day07.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(r'''
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
'''
              .asLines),
          equals(3749));
    });
    test('Solution', () {
      expect(solveA(input), equals(2314935962622));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
          solveB(r'''
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
'''
              .asLines),
          equals(11387));
    });
    test('Solution', () {
      expect(solveB(input), equals(401477450831495));
    });
  });
}
