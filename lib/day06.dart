// --- Day 6: Guard Gallivant ---
// https://adventofcode.com/2024/day/6

import 'dart:typed_data';

const guardChar = 94; // ^
const emptyChar = 46; // .
const obstructionChar = 35; // #

const movements = [
  // Up
  Point(0, -1),
  // Right
  Point(1, 0),
  // Down
  Point(0, 1),
  // Left
  Point(-1, 0),
];

int solveA(List<String> input) =>
    getDistinctPositions(input).distinctPositions.length;

int solveB(List<String> input) {
  final (:distinctPositions, :grid) = getDistinctPositions(input);

  // Now contains places we can place obstacles
  distinctPositions.remove(grid.guardStartingPoint);
  var loopPositions = 0;

  for (final distinctPosition in distinctPositions) {
    // Put obstacle at position
    grid.setByPoint(distinctPosition, obstructionChar);

    // Point and direction set. If we detect the same combo, we are in loop
    final loopDetect = <(Point, int)>{};
    var guardPosition = grid.guardStartingPoint;
    var direction = 0;

    while (true) {
      if (!loopDetect.add((guardPosition, direction))) {
        loopPositions++;
        break;
      }

      final nextGuardPosition = guardPosition + movements[direction];
      final objectOnNewPosition = grid.getByPoint(nextGuardPosition);

      if (objectOnNewPosition == null) {
        // Hit outside of grid which means we are done
        break;
      } else if (objectOnNewPosition == obstructionChar) {
        // Hit obstacle so rotate
        direction = (direction + 1) % movements.length;
      } else {
        // Move to free space
        guardPosition = nextGuardPosition;
      }
    }

    // Reset grid back to original map
    grid.setByPoint(distinctPosition, emptyChar);
  }

  return loopPositions;
}

({Set<Point> distinctPositions, Grid grid}) getDistinctPositions(
  List<String> input,
) {
  final grid = Grid(input.first.length, input.length)..setFromInput(input);
  final distinctPositions = <Point>{};

  var guardPosition = grid.guardStartingPoint;
  var direction = 0;

  while (true) {
    distinctPositions.add(guardPosition);

    final nextGuardPosition = guardPosition + movements[direction];
    final objectOnNewPosition = grid.getByPoint(nextGuardPosition);

    if (objectOnNewPosition == null) {
      // Hit outside of grid which means we are done
      break;
    } else if (objectOnNewPosition == obstructionChar) {
      // Hit obstacle so rotate
      direction = (direction + 1) % movements.length;
    } else {
      // Move to free space
      guardPosition = nextGuardPosition;
    }
  }

  return (distinctPositions: distinctPositions, grid: grid);
}

extension type const Point._(({int x, int y}) _point) {
  const Point(int x, int y) : this._((x: x, y: y));

  int get x => _point.x;
  int get y => _point.y;

  Point operator +(Point other) => Point(
        x + other.x,
        y + other.y,
      );

  Point operator -(Point other) => Point(
        x - other.x,
        y - other.y,
      );
}

class Grid {
  final int length, height;
  final Uint8List _list;
  late final Point guardStartingPoint;

  Grid(this.length, this.height) : _list = Uint8List(length * height);

  int? getByPoint(Point p) => get(p.x, p.y);
  int? get(int x, int y) => (x >= 0 && x < length && y >= 0 && y < height)
      ? _list[_getPos(x, y)]
      : null;

  void setByPoint(Point p, int value) => set(p.x, p.y, value);
  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) => x + (y * length);

  void setFromInput(List<String> input) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        final codeUnit = line.codeUnitAt(x);
        set(x, y, codeUnit);

        if (codeUnit == guardChar) {
          guardStartingPoint = Point(x, y);
        }
      }
    }
  }
}