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
const charOpenBox = 91; // [
const charCloseBox = 93; // ]

const directionLeft = Point(-1, 0);
const directionRight = Point(1, 0);
const directionUp = Point(0, -1);
const directionDown = Point(0, 1);

int solveA(Iterable<String> input) => solve(
      input,
      partB: false,
      canRobotMove: (grid, direction) {
        var nextPoint = grid.robotPosition + direction;

        while (true) {
          final nextChar = grid.getByPoint(nextPoint);

          if (nextChar == charEmpty) {
            return true;
          } else if (nextChar == charWall) {
            return false;
          }

          nextPoint += direction;
        }
      },
      moveRobot: (grid, direction) {
        var nextPoint = grid.robotPosition + direction;
        var nextChar = grid.getByPoint(nextPoint);

        // We do this regardless
        grid
          ..setByPoint(nextPoint, charRobot)
          ..setByPoint(grid.robotPosition, charEmpty)
          ..robotPosition = nextPoint;

        if (nextChar == charEmpty) {
          return;
        }

        // We need to move some boxes. Find first empty space forward and put a
        // box here instead of actually moving potentially multiple boxes
        // forward.
        do {
          nextPoint += direction;
          nextChar = grid.getByPoint(nextPoint);
        } while (nextChar != charEmpty);

        grid.setByPoint(nextPoint, charBox);
      },
    );

int solveB(Iterable<String> input) => solve(
      input,
      partB: true,
      canRobotMove: (grid, direction) {
        if (direction == directionRight || direction == directionLeft) {
          var nextPoint = grid.robotPosition + direction;

          while (true) {
            final nextChar = grid.getByPoint(nextPoint);

            if (nextChar == charEmpty) {
              return true;
            } else if (nextChar == charWall) {
              return false;
            }

            nextPoint += direction;
          }
        } else {
          bool canMove(Grid grid, Point position, Point direction) {
            final nextPoint = position + direction;
            final nextChar = grid.getByPoint(nextPoint);

            return switch (nextChar) {
              charEmpty => true,
              charWall => false,
              charOpenBox => canMove(grid, nextPoint, direction) &&
                  canMove(grid, nextPoint + directionRight, direction),
              charCloseBox => canMove(grid, nextPoint, direction) &&
                  canMove(grid, nextPoint + directionLeft, direction),
              _ => throw Exception("Don't understand: $nextChar = "
                  "${String.fromCharCode(nextChar)}\n$grid")
            };
          }

          return canMove(grid, grid.robotPosition, direction);
        }
      },
      moveRobot: (grid, direction) {
        void push(Grid grid, Point position, Point direction) {
          final currentChar = grid.getByPoint(position);
          final nextPoint = position + direction;
          final nextChar = grid.getByPoint(nextPoint);

          if (direction == directionRight || direction == directionLeft) {
            if (nextChar != charEmpty) {
              push(grid, nextPoint, direction);
            }
          } else {
            if (nextChar == charOpenBox) {
              final nextClosingBoxPosition = nextPoint + directionRight;

              push(grid, nextPoint, direction);
              push(grid, nextClosingBoxPosition, direction);
              grid.setByPoint(nextClosingBoxPosition, charEmpty);
            } else if (nextChar == charCloseBox) {
              final nextOpeningBoxPosition = nextPoint + directionLeft;

              push(grid, nextPoint, direction);
              push(grid, nextOpeningBoxPosition, direction);
              grid.setByPoint(nextOpeningBoxPosition, charEmpty);
            }
          }

          grid.setByPoint(nextPoint, currentChar);
        }

        push(grid, grid.robotPosition, direction);
        grid
          ..setByPoint(grid.robotPosition, charEmpty)
          ..robotPosition += direction;
      },
    );

int solve(
  Iterable<String> input, {
  required bool Function(Grid grid, Point direction) canRobotMove,
  required void Function(Grid grid, Point direction) moveRobot,
  required bool partB,
}) {
  final inputIterator = input.iterator..moveNext();
  final grid = getGrid(inputIterator, partB: partB);

  while (inputIterator.moveNext()) {
    final instructions = inputIterator.current;

    for (var i = 0; i < instructions.length; i++) {
      final direction = switch (instructions.codeUnitAt(i)) {
        charLeft => directionLeft,
        charRight => directionRight,
        charUp => directionUp,
        charDown => directionDown,
        final instruction =>
          throw Exception('Unknown instruction: $instruction = '
              '${String.fromCharCode(instruction)}'),
      };

      if (canRobotMove(grid, direction)) {
        moveRobot(grid, direction);
      }
    }
  }

  var sum = 0;

  for (var y = 0; y < grid.height; y++) {
    for (var x = 0; x < grid.length; x++) {
      final char = grid.get(x, y);

      if (char == charBox || char == charOpenBox) {
        sum += (100 * y) + x;
      }
    }
  }

  return sum;
}

Grid getGrid(Iterator<String> inputIterator, {required bool partB}) {
  final lines = <String>[];

  while (inputIterator.current != '') {
    lines.add(
      partB ? expandLine(inputIterator.current) : inputIterator.current,
    );
    inputIterator.moveNext();
  }

  return Grid(lines);
}

String expandLine(String line) {
  final sb = StringBuffer();

  for (var i = 0; i < line.length; i++) {
    sb.write(switch (line.codeUnitAt(i)) {
      charWall => '##',
      charBox => '[]',
      charEmpty => '..',
      charRobot => '@.',
      final char => throw Exception('Unknown char: $char'),
    });
  }

  return sb.toString();
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

  int _getPos(int x, int y) {
    assert(
      x >= 0 && y >= 0 && x < length && y < height,
      '(x:$x y:$y) are outside range (length: $length, height: $height)!',
    );
    return x + (y * length);
  }

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
