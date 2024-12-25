// --- Day 13: Claw Contraption ---
// https://adventofcode.com/2024/day/13

import 'dart:io';
import 'package:advent_of_code_2024/day13.dart';
import 'package:advent_of_code_2024/util.dart';
import 'package:test/test.dart';

final input = File('test/data/day13.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(r'''
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400
'''
              .asLines),
          equals(280));
    });
    test('Example 2', () {
      expect(
          solveA(r'''
Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176
'''
              .asLines),
          equals(0));
    });
    test('Example 3', () {
      expect(
          solveA(r'''
Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450
'''
              .asLines),
          equals(200));
    });
    test('Example 4', () {
      expect(
          solveA(r'''
Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
'''
              .asLines),
          equals(0));
    });
    test('Example 5', () {
      expect(
          solveA(r'''
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
'''
              .asLines),
          equals(480));
    });
    test('Solution', () {
      expect(solveA(input), equals(36571));
    });
  });
}
