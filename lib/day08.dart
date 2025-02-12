// --- Day 8: Resonant Collinearity ---
// https://adventofcode.com/2024/day/8

import 'dart:collection';

import 'package:collection/collection.dart';

typedef Point = ({int x, int y});

int solveA(List<String> input) => solve(input, partB: false);
int solveB(List<String> input) => solve(input, partB: true);

int solve(List<String> input, {required bool partB}) {
  final maxX = input.first.length;
  final maxY = input.length;

  final antennas = <String, List<Point>>{};
  final antinodes = HashSet<Point>();

  bool addAntinode(Point point) {
    if (point.x >= 0 && point.x < maxX && point.y >= 0 && point.y < maxY) {
      antinodes.add(point);
      return true;
    }
    return false;
  }

  for (var (y, line) in input.indexed) {
    for (var (x, char) in line.split('').indexed) {
      if (char == '.') {
        continue;
      }
      antennas.update(
        char,
        (list) => list..add((x: x, y: y)),
        ifAbsent: () => [(x: x, y: y)],
      );
    }
  }

  for (final antennas in antennas.values) {
    for (final (p1, p2) in antennas.pairs) {
      final xDistance = p1.x - p2.x;
      final yDistance = p1.y - p2.y;

      if (partB) {
        for (
          var i = 1;
          addAntinode((x: p1.x + xDistance * i, y: p1.y + yDistance * i));
          i++
        ) {}
        for (
          var i = 1;
          addAntinode((x: p2.x - xDistance * i, y: p2.y - yDistance * i));
          i++
        ) {}
      } else {
        addAntinode((x: p1.x + xDistance, y: p1.y + yDistance));
        addAntinode((x: p2.x - xDistance, y: p2.y - yDistance));
      }
    }
  }

  if (partB) {
    antinodes.addAll(antennas.values.flattened);
  }

  return antinodes.length;
}

extension<T> on List<T> {
  Iterable<(T, T)> get pairs sync* {
    for (var i = 0; i < length; i++) {
      for (var k = i + 1; k < length; k++) {
        yield (this[i], this[k]);
      }
    }
  }
}
