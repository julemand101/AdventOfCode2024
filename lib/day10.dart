// --- Day 10: Hoof It ---
// https://adventofcode.com/2024/day/10

import 'dart:collection';
import 'dart:typed_data';

int solveA(List<String> input) {
  final grid = Grid(input.first.length + 2, input.length + 2)
    ..setFromInput(input, padding: 1);
  var sum = 0;

  for (final startingPosition in grid.zeroPositions) {
    sum += reachTop(grid, startingPosition, 0, HashSet());
  }

  return sum;
}

int solveB(List<String> input) {
  return 0;
}

final Point up = Point(0, -1);
final Point right = Point(1, 0);
final Point down = Point(0, 1);
final Point left = Point(-1, 0);

int reachTop(
  Grid grid,
  Point currentPosition,
  int nextLevel,
  Set<Point> visitedBefore,
) {
  final currentValue = grid.getByPoint(currentPosition);

  if (currentValue != nextLevel) {
    return 0;
  }

  if (currentValue == 9) {
    return visitedBefore.add(currentPosition) ? 1 : 0;
  }

  return reachTop(grid, currentPosition + up, nextLevel + 1, visitedBefore) +
      reachTop(grid, currentPosition + right, nextLevel + 1, visitedBefore) +
      reachTop(grid, currentPosition + down, nextLevel + 1, visitedBefore) +
      reachTop(grid, currentPosition + left, nextLevel + 1, visitedBefore);
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
  final List<Point> zeroPositions = [];

  Grid(this.length, this.height) : _list = Uint8List(length * height);

  int getByPoint(Point p) => get(p.x, p.y);
  int get(int x, int y) => _list[_getPos(x, y)];

  void setByPoint(Point p, int value) => set(p.x, p.y, value);
  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) => x + (y * length);

  void setFromInput(List<String> input, {int padding = 0}) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        if (line[x] == '.') {
          set(x + padding, y + padding, 255);
        } else {
          final intValue = int.parse(line[x]);
          set(x + padding, y + padding, intValue);

          if (intValue == 0) {
            zeroPositions.add(Point(x + padding, y + padding));
          }
        }
      }
    }
  }
}
