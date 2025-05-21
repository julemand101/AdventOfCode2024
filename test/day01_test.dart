// --- Day 1: Historian Hysteria ---
// https://adventofcode.com/2024/day/1

import 'dart:io';
import 'package:advent_of_code_2024/day01.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day01.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
3   4
4   3
2   5
1   3
3   9
3   3
'''
              .asLines,
        ),
        equals(11),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(1341714));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(
          r'''
3   4
4   3
2   5
1   3
3   9
3   3
'''
              .asLines,
        ),
        equals(31),
      );
    });
    test('Solution', () {
      expect(solveB(input), equals(27384707));
    });
  });
}
