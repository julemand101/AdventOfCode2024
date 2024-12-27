// --- Day 15: Warehouse Woes ---
// https://adventofcode.com/2024/day/15

import 'dart:typed_data';

const charLeft = 60; //  <
const charRight = 62; // >
const charUp = 94; //    ^
const charDown = 118; // v
const charWall = 35; //  #
const charEmpty = 46; // .
const charBox = 79; //   0
const charRobot = 64; // @

const directionLeft = Point(-1, 0);
const directionRight = Point(1, 0);
const directionUp = Point(0, -1);
const directionDown = Point(0, 1);

const directionMap = {
  charLeft: directionLeft,
  charRight: directionRight,
  charUp: directionUp,
  charDown: directionDown,
};

int solveA(Iterable<String> input) {
  final inputIterator = input.iterator..moveNext();
  final grid = getGrid(inputIterator);

  while (inputIterator.moveNext()) {
    final instructions = inputIterator.current;

    for (var i = 0; i < instructions.length; i++) {
      final instruction = instructions.codeUnitAt(i);
      final direction = directionMap[instruction]!;

      if (grid.canRobotMove(direction)) {
        grid.moveRobot(direction);
      }
    }
  }

  var sum = 0;

  for (var y = 0; y < grid.height; y++) {
    for (var x = 0; x < grid.length; x++) {
      if (grid.get(x, y) == charBox) {
        sum += (100 * y) + x;
      }
    }
  }

  return sum;
}

Grid getGrid(Iterator<String> inputIterator) {
  final lines = <String>[];

  while (inputIterator.current != '') {
    lines.add(inputIterator.current);
    inputIterator.moveNext();
  }

  return Grid(lines);
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
  late Point robotPosition;

  Grid(List<String> input)
      : length = input.first.length,
        height = input.length,
        _list = Uint8List((input.length * input.first.length)) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        final char = line.codeUnitAt(x);

        if (char == charRobot) {
          robotPosition = Point(x, y);
        }

        set(x, y, char);
      }
    }
  }

  int getByPoint(Point p) => get(p.x, p.y);
  int get(int x, int y) => _list[_getPos(x, y)];

  void setByPoint(Point p, int value) => set(p.x, p.y, value);
  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) => x + (y * length);

  bool canRobotMove(Point direction) {
    var nextPoint = robotPosition + direction;

    while (true) {
      final nextChar = getByPoint(nextPoint);

      if (nextChar == charEmpty) {
        return true;
      } else if (nextChar == charWall) {
        return false;
      }

      nextPoint += direction;
    }
  }

  void moveRobot(Point direction) {
    var nextPoint = robotPosition + direction;
    var nextChar = getByPoint(nextPoint);

    // We do this regardless
    setByPoint(nextPoint, charRobot);
    setByPoint(robotPosition, charEmpty);
    robotPosition = nextPoint;

    if (nextChar == charEmpty) {
      return;
    }

    // We need to move some boxes. Find first empty space forward and put a box
    // here instead of actually moving potentially multiple boxes forward.
    do {
      nextPoint += direction;
      nextChar = getByPoint(nextPoint);
    } while (nextChar != charEmpty);

    setByPoint(nextPoint, charBox);
  }
}
