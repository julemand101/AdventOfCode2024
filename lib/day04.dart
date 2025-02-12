// --- Day 4: Ceres Search ---
// https://adventofcode.com/2024/day/4

import 'dart:typed_data';

// ASCII values
const int letterX = 88;
const int letterM = 77;
const int letterA = 65;
const int letterS = 83;

class Grid {
  final int length, height;
  final Uint8List _list;

  Grid(this.length, this.height) : _list = Uint8List(length * height);

  int? get(int x, int y) =>
      (x >= 0 && x < length && y >= 0 && y < height)
          ? _list[_getPos(x, y)]
          : null;

  void set(int x, int y, int value) => _list[_getPos(x, y)] = value;

  int _getPos(int x, int y) => x + (y * length);

  void setFromInput(List<String> input) {
    for (final (y, line) in input.indexed) {
      for (var x = 0; x < line.length; x++) {
        set(x, y, line.codeUnitAt(x));
      }
    }
  }
}

int solveA(List<String> input) {
  final grid = Grid(input.first.length, input.length)..setFromInput(input);
  var xmasCount = 0;

  for (var y = 0; y <= grid.height; y++) {
    for (var x = 0; x <= grid.length; x++) {
      if (grid.get(x, y) == letterX) {
        // horizontal
        if (checkWord(
          grid.get(x + 1, y),
          grid.get(x + 2, y),
          grid.get(x + 3, y),
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid.get(x - 1, y),
          grid.get(x - 2, y),
          grid.get(x - 3, y),
        )) {
          xmasCount++;
        }

        // vertical
        if (checkWord(
          grid.get(x, y + 1),
          grid.get(x, y + 2),
          grid.get(x, y + 3),
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid.get(x, y - 1),
          grid.get(x, y - 2),
          grid.get(x, y - 3),
        )) {
          xmasCount++;
        }

        // diagonal
        if (checkWord(
          grid.get(x + 1, y + 1),
          grid.get(x + 2, y + 2),
          grid.get(x + 3, y + 3),
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid.get(x - 1, y - 1),
          grid.get(x - 2, y - 2),
          grid.get(x - 3, y - 3),
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid.get(x + 1, y - 1),
          grid.get(x + 2, y - 2),
          grid.get(x + 3, y - 3),
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid.get(x - 1, y + 1),
          grid.get(x - 2, y + 2),
          grid.get(x - 3, y + 3),
        )) {
          xmasCount++;
        }
      }
    }
  }

  return xmasCount;
}

// First letter have already been checked to be `X`
bool checkWord(int? letter2, int? letter3, int? letter4) =>
    letter2 == letterM && letter3 == letterA && letter4 == letterS;

int solveB(List<String> input) {
  final grid = Grid(input.first.length, input.length)..setFromInput(input);
  var xmasCount = 0;

  for (var y = 0; y <= grid.height; y++) {
    for (var x = 0; x <= grid.length; x++) {
      if (grid.get(x, y) == letterM &&
          grid.get(x + 2, y) == letterS &&
          grid.get(x + 1, y + 1) == letterA &&
          grid.get(x, y + 2) == letterM &&
          grid.get(x + 2, y + 2) == letterS) {
        xmasCount++;
      } else if (grid.get(x, y) == letterS &&
          grid.get(x + 2, y) == letterS &&
          grid.get(x + 1, y + 1) == letterA &&
          grid.get(x, y + 2) == letterM &&
          grid.get(x + 2, y + 2) == letterM) {
        xmasCount++;
      } else if (grid.get(x, y) == letterM &&
          grid.get(x + 2, y) == letterM &&
          grid.get(x + 1, y + 1) == letterA &&
          grid.get(x, y + 2) == letterS &&
          grid.get(x + 2, y + 2) == letterS) {
        xmasCount++;
      } else if (grid.get(x, y) == letterS &&
          grid.get(x + 2, y) == letterM &&
          grid.get(x + 1, y + 1) == letterA &&
          grid.get(x, y + 2) == letterS &&
          grid.get(x + 2, y + 2) == letterM) {
        xmasCount++;
      }
    }
  }

  return xmasCount;
}
