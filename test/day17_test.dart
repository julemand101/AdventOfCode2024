// --- Day 17: Chronospatial Computer ---
// https://adventofcode.com/2024/day/17

import 'dart:io';
import 'package:advent_of_code_2024/day17.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day17.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
'''
              .asLines,
        ),
        equals('4,6,3,5,6,3,5,2,1,0'),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals('7,4,2,5,1,4,6,0,4'));
    });
  });
}
