// --- Day 14: Restroom Redoubt ---
// https://adventofcode.com/2024/day/14

import 'dart:typed_data';

int solveA(Iterable<String> input, {int wide = 101, int tall = 103}) {
  final robots = [...input.map(Robot.new)];

  for (var second = 0; second < 100; second++) {
    for (final robot in robots) {
      robot.move(wide: wide, tall: tall);
    }
  }

  var q1 = 0;
  var q2 = 0;
  var q3 = 0;
  var q4 = 0;

  final middleWide = (wide ~/ 2);
  final middleTall = (tall ~/ 2);

  for (final robot in robots) {
    var (:x, :y) = robot.position._point;

    if (x < middleWide && y < middleTall) {
      q1++;
    } else if (x > middleWide && y < middleTall) {
      q2++;
    } else if (x < middleWide && y > middleTall) {
      q3++;
    } else if (x > middleWide && y > middleTall) {
      q4++;
    }
  }

  return q1 * q2 * q3 * q4;
}

int solveB(Iterable<String> input, {int wide = 101, int tall = 103}) {
  final robots = [...input.map(Robot.new)];

  for (var second = 1; second <= 10000; second++) {
    final grid = Grid(wide, tall);

    for (final robot in robots) {
      grid.setRobot(robot..move(wide: wide, tall: tall));
    }

    if (grid.foundTree()) {
      return second;
    }
  }

  return 0;
}

String printGrid(List<Robot> robots, int wide, int tall) {
  Map<Point, int> robotCount = {};

  for (final robot in robots) {
    robotCount.update(robot.position, (i) => i + 1, ifAbsent: () => 1);
  }

  final sb = StringBuffer();
  for (var y = 0; y < tall; y++) {
    for (var x = 0; x < wide; x++) {
      sb.write(robotCount[Point(x, y)] ?? '.');
    }
    sb.writeln();
  }
  return sb.toString();
}

// p=0,4 v=3,-3
final robotRegExp = RegExp(r'p=(.*),(.*) v=(.*),(.*)');

class Robot {
  Point position;
  final Point velocity;

  Robot._({required this.position, required this.velocity});

  factory Robot(String line) {
    final [px, py, vx, vy] = [
      ...robotRegExp
          .firstMatch(line)!
          .groups([1, 2, 3, 4]).map((s) => int.parse(s!))
    ];

    return Robot._(position: Point(px, py), velocity: Point(vx, vy));
  }

  void move({required int wide, required int tall}) {
    position = (position + velocity) % Point(wide, tall);
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

  Point operator %(Point other) => Point(
        x % other.x,
        y % other.y,
      );
}

class Grid {
  final int length, height;
  final Uint8List _list;

  Grid(this.length, this.height) : _list = Uint8List(length * height);

  void setRobot(Robot robot) =>
      _list[_getPos(robot.position.x, robot.position.y)] += 1;

  // Tree to be found:
  // 1111111111111111111111111111111
  // 1.............................1
  // 1.............................1
  // 1.............................1
  // 1.............................1
  // 1..............1..............1
  // 1.............111.............1
  // 1............11111............1
  // 1...........1111111...........1
  // 1..........111111111..........1
  // 1............11111............1
  // 1...........1111111...........1
  // 1..........111111111..........1
  // 1.........11111111111.........1
  // 1........1111111111111........1
  // 1..........111111111..........1
  // 1.........11111111111.........1
  // 1........1111111111111........1
  // 1.......111111111111111.......1
  // 1......11111111111111111......1
  // 1........1111111111111........1
  // 1.......111111111111111.......1
  // 1......11111111111111111......1
  // 1.....1111111111111111111.....1
  // 1....111111111111111111111....1
  // 1.............111.............1
  // 1.............111.............1
  // 1.............111.............1
  // 1.............................1
  // 1.............................1
  // 1.............................1
  // 1.............................1
  // 1111111111111111111111111111111
  bool foundTree() {
    // We look for the bottom branch of the tree:
    // 111111111111111111111
    final numberOfConsecutiveRobots = 21;
    var count = 0;

    for (final value in _list) {
      if (value == 1) {
        if (++count == numberOfConsecutiveRobots) {
          return true;
        }
      } else {
        count = 0;
      }
    }

    return false;
  }

  int _getPos(int x, int y) => x + (y * length);
}
