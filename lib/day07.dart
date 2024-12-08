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
    final numbers = [...rest.split(' ').map(int.parse)];

    if (tryOperators(numbers, testValue, partB: false)) {
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
          final numbers = [...rest.split(' ').map(int.parse)];

          if (tryOperators(numbers, testValue, partB: true)) {
            totalCalibrationResult += testValue;
          }
        }

        return totalCalibrationResult;
      }),
  ].wait)
      .sum;
}

bool tryOperators(
  List<int> numbers,
  int target, {
  int result = 0,
  int pos = 0,
  required bool partB,
}) {
  if (result > target) {
    return false;
  }
  if (pos == numbers.length) {
    return target == result;
  }
  return tryOperators(
        numbers,
        target,
        result: numbers[pos] + result,
        pos: pos + 1,
        partB: partB,
      ) ||
      tryOperators(
        numbers,
        target,
        result: numbers[pos] * result,
        pos: pos + 1,
        partB: partB,
      ) ||
      (partB &&
          tryOperators(
            numbers,
            target,
            result: int.parse('$result${numbers[pos]}'),
            pos: pos + 1,
            partB: partB,
          ));
}
