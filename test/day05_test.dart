// --- Day 5: Print Queue ---
// https://adventofcode.com/2024/day/5

import 'dart:io';
import 'package:advent_of_code_2024/day05.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day05.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(
          r'''
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
'''.asLines,
        ),
        equals(143),
      );
    });
    test('Solution', () {
      expect(solveA(input), equals(6951));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(
          r'''
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
'''.asLines,
        ),
        equals(123),
      );
    });
    test('Solution', () {
      expect(solveB(input), equals(4121));
    });
  });
}
