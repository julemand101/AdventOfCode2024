// --- Day 16: Reindeer Maze ---
// https://adventofcode.com/2024/day/16

import 'dart:collection';
import 'dart:typed_data';

import 'package:collection/collection.dart';

const charWall = 35; //  #
const charEmpty = 46; // .
const charStart = 83; // S
const charEnd = 69; //   E

enum Direction {
  north(Point(0, -1)),
  east(Point(1, 0)),
  south(Point(0, 1)),
  west(Point(-1, 0));

  final Point delta;

  Direction get left => Direction.values[(index - 1) % 4];

  Direction get right => Direction.values[(index + 1) % 4];

  const Direction(this.delta);
}

int solveA(List<String> input) {
  final grid = Grid(input);
  final startPosition = PointWithDirection(grid.start, Direction.east);
  final pastVisits = HashSet<PointWithDirection>();
  final unsettledPoints = PriorityQueue<PointWithDirectionAndCost>(
    (p1, p2) => p1.cost.compareTo(p2.cost),
  )..add((point: startPosition, cost: 0));

  while (unsettledPoints.isNotEmpty) {
    final point = unsettledPoints.removeFirst();

    if (point.point.point == grid.end) {
      return point.cost;
    }

    if (!pastVisits.add(point.point)) {
      continue;
    }

    unsettledPoints.addAll(grid.findOptions(point));
  }

  return 0;
}

extension type const Point._(({int x, int y}) _point) {
  const Point(int x, int y) : this._((x: x, y: y));

  int get x => _point.x;

  int get y => _point.y;

  Point operator +(Point other) => Point(x + other.x, y + other.y);

  Point operator -(Point other) => Point(x - other.x, y - other.y);
}

extension type const PointWithDirection._(
  ({Point point, Direction direction}) _point
) {
  const PointWithDirection(Point point, Direction direction)
    : this._((point: point, direction: direction));

  Point get point => _point.point;

  Direction get direction => _point.direction;

  PointWithDirection get moveForward => //
      PointWithDirection(point + direction.delta, direction);

  PointWithDirection get moveLeft => //
      PointWithDirection(point, direction.left);

  PointWithDirection get moveRight => //
      PointWithDirection(point, direction.right);
}

typedef PointWithDirectionAndCost = ({PointWithDirection point, int cost});

class Grid {
  final int length, height;
  final Uint8List _list;
  late final Point start;
  late final Point end;

  Grid(List<String> input)
    : length = input.first.length,
      height = input.length,
      _list = Uint8List((input.length * input.first.length)) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        final char = line.codeUnitAt(x);

        if (char == charStart) {
          start = Point(x, y);
        } else if (char == charEnd) {
          end = Point(x, y);
        }

        set(x, y, char);
      }
    }
  }

  int getByPoint(Point p) => get(p.x, p.y);

  int get(int x, int y) => _list[_getPos(x, y)];

  void setByPoint(Point p, int value) => set(p.x, p.y, value);

  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) {
    assert(
      x >= 0 && y >= 0 && x < length && y < height,
      '(x:$x y:$y) are outside range (length: $length, height: $height)!',
    );
    return x + (y * length);
  }

  List<PointWithDirectionAndCost> findOptions(
    PointWithDirectionAndCost currentPosition,
  ) => [
    if (currentPosition.point.moveForward case final forwardPosition
        when getByPoint(forwardPosition.point) != charWall)
      (point: forwardPosition, cost: currentPosition.cost + 1),
    (point: currentPosition.point.moveLeft, cost: currentPosition.cost + 1000),
    (point: currentPosition.point.moveRight, cost: currentPosition.cost + 1000),
  ];

  @override
  String toString() {
    final sb = StringBuffer();

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < length; x++) {
        sb.writeCharCode(get(x, y));
      }
      sb.writeln();
    }

    return sb.toString();
  }
}
