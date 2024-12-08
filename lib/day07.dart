// --- Day 7: Bridge Repair ---
// https://adventofcode.com/2024/day/7

import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';

int solveA(Iterable<String> input) {
  var totalCalibrationResult = 0;

  for (final line in input) {
    final [testValueString, rest] = line.split(': ');
    final testValue = int.parse(testValueString);
    final numbers = [...rest.split(' ').reversed.map(int.parse)];

    if (tryOperators1(numbers, testValue, 0).contains(testValue)) {
      totalCalibrationResult += testValue;
    }
  }

  return totalCalibrationResult;
}

Iterable<int> tryOperators1(List<int> numbers, int target, int pos) sync* {
  if (pos == numbers.length - 1) {
    yield numbers.last;
  } else {
    yield* tryOperators1(numbers, target, pos + 1)
        .map((value) => value + numbers[pos]);
    yield* tryOperators1(numbers, target, pos + 1)
        .map((value) => value * numbers[pos]);
  }
}

Future<int> solveB(List<String> input) async {
  final jobsPerCore = input.length ~/ Platform.numberOfProcessors;

  return (await [
    for (final lines in input.slices(jobsPerCore + 1))
      Isolate.run(() {
        var totalCalibrationResult = 0;

        for (final line in lines) {
          final [testValueString, rest] = line.split(': ');
          final testValue = int.parse(testValueString);
          final numbers = [...rest.split(' ').reversed.map(int.parse)];

          if (tryOperators2(numbers, testValue, 0).contains(testValue)) {
            totalCalibrationResult += testValue;
          }
        }

        return totalCalibrationResult;
      }),
  ].wait)
      .sum;
}

Iterable<int> tryOperators2(List<int> numbers, int target, int pos) sync* {
  if (pos == numbers.length - 1) {
    yield numbers.last;
  } else {
    yield* tryOperators2(numbers, target, pos + 1)
        .map((value) => value + numbers[pos]);
    yield* tryOperators2(numbers, target, pos + 1)
        .map((value) => value * numbers[pos]);
    yield* tryOperators2(numbers, target, pos + 1)
        .map((value) => int.parse('$value${numbers[pos]}'));
  }
}
