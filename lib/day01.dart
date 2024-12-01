// --- Day 1: Historian Hysteria ---
// https://adventofcode.com/2024/day/1

import 'package:collection/collection.dart';

int solveA(Iterable<String> input) {
  final listA = <int>[];
  final listB = <int>[];

  for (final line in input) {
    final [valueA, valueB] = line.split('   ');
    listA.add(int.parse(valueA));
    listB.add(int.parse(valueB));
  }

  listA.sort();
  listB.sort();

  var distanceSum = 0;

  for (final (index, valueA) in listA.indexed) {
    distanceSum += (valueA - listB[index]).abs();
  }

  return distanceSum;
}

int solveB(Iterable<String> input) {
  final listA = <int>[];
  final countMapB = <int, int>{};

  for (final line in input) {
    final [valueA, valueB] = line.split('   ');
    listA.add(int.parse(valueA));
    countMapB.update(int.parse(valueB), (i) => i + 1, ifAbsent: () => 1);
  }

  return listA.map((valueA) => valueA * (countMapB[valueA] ?? 0)).sum;
}
