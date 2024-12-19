// --- Day 12: Garden Groups ---
// https://adventofcode.com/2024/day/12

import 'dart:collection';
import 'dart:typed_data';

int solveA(List<String> input) {
  final grid = Grid(input);
  final todoQueue = Queue<Point>()..add(Point(0, 0));
  final pointsAlreadyPartOfGroupSet = HashSet<Point>();
  var sum = 0;

  while (todoQueue.isNotEmpty) {
    final currentPoint = todoQueue.removeFirst();

    if (pointsAlreadyPartOfGroupSet.contains(currentPoint)) {
      continue;
    }

    var fences = 0;
    var plots = 0;
    for (final plotPoint in scan(
      currentPoint,
      grid.getByPoint(currentPoint),
      grid,
      todoQueue,
      pointsAlreadyPartOfGroupSet,
    )) {
      pointsAlreadyPartOfGroupSet.add(plotPoint);
      plots++;

      final currentChar = grid.getByPoint(plotPoint);

      // Scan neighbours
      for (final scan in scanningList) {
        // If neighbour are stranger, then we put up a fence
        if (grid.getByPoint(plotPoint + scan) != currentChar) {
          fences++;
        }
      }
    }

    sum += fences * plots;
  }

  return sum;
}

const scanningList = [
  Point(0, -1), // up
  Point(1, 0), // right
  Point(0, 1), // down
  Point(-1, 0), // left
];

const outsideGrid = 0;

Iterable<Point> scan(
  Point currentPoint,
  int lookFor,
  Grid grid,
  Queue<Point> todo,
  Set<Point> history,
) sync* {
  final currentValue = grid.getByPoint(currentPoint);

  if (currentValue == outsideGrid) {
    return;
  }
  if (currentValue != lookFor) {
    todo.add(currentPoint);
    return;
  }
  if (!history.add(currentPoint)) {
    return;
  }

  yield currentPoint;

  for (final scanning in scanningList) {
    yield* scan(currentPoint + scanning, lookFor, grid, todo, history);
  }
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

  Grid(List<String> input)
      : length = input.first.length,
        height = input.length,
        _list = Uint8List((input.length * input.first.length)) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        set(x, y, line.codeUnitAt(x));
      }
    }
  }

  int getByPoint(Point p) => get(p.x, p.y);
  int get(int x, int y) => (x < 0 || y < 0 || x >= length || y >= height)
      ? outsideGrid
      : _list[_getPos(x, y)];

  void setByPoint(Point p, int value) => set(p.x, p.y, value);
  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) => x + (y * length);
}
