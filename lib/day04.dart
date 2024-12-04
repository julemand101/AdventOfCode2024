// --- Day 4: Ceres Search ---
// https://adventofcode.com/2024/day/4

import 'dart:math';

int solveA(Iterable<String> input) {
  final grid = <(int x, int y), String>{};
  var maxX = 0;
  var maxY = 0;

  for (final (y, line) in input.indexed) {
    maxY = max(maxY, y);

    for (final (x, letter) in line.split('').indexed) {
      maxX = max(maxX, x);
      grid[(x, y)] = letter;
    }
  }

  var xmasCount = 0;

  for (var y = 0; y <= maxY; y++) {
    for (var x = 0; x <= maxX; x++) {
      if (grid[(x, y)] == 'X') {
        // horizontal
        if (checkWord(
          grid[(x, y)],
          grid[(x + 1, y)],
          grid[(x + 2, y)],
          grid[(x + 3, y)],
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid[(x, y)],
          grid[(x - 1, y)],
          grid[(x - 2, y)],
          grid[(x - 3, y)],
        )) {
          xmasCount++;
        }

        // vertical
        if (checkWord(
          grid[(x, y)],
          grid[(x, y + 1)],
          grid[(x, y + 2)],
          grid[(x, y + 3)],
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid[(x, y)],
          grid[(x, y - 1)],
          grid[(x, y - 2)],
          grid[(x, y - 3)],
        )) {
          xmasCount++;
        }

        // diagonal
        if (checkWord(
          grid[(x, y)],
          grid[(x + 1, y + 1)],
          grid[(x + 2, y + 2)],
          grid[(x + 3, y + 3)],
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid[(x, y)],
          grid[(x - 1, y - 1)],
          grid[(x - 2, y - 2)],
          grid[(x - 3, y - 3)],
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid[(x, y)],
          grid[(x + 1, y - 1)],
          grid[(x + 2, y - 2)],
          grid[(x + 3, y - 3)],
        )) {
          xmasCount++;
        }
        if (checkWord(
          grid[(x, y)],
          grid[(x - 1, y + 1)],
          grid[(x - 2, y + 2)],
          grid[(x - 3, y + 3)],
        )) {
          xmasCount++;
        }
      }
    }
  }

  return xmasCount;
}

bool checkWord(
  String? letter1,
  String? letter2,
  String? letter3,
  String? letter4,
) =>
    (letter1 == 'X' && letter2 == 'M' && letter3 == 'A' && letter4 == 'S') ||
    (letter1 == 'S' && letter2 == 'A' && letter3 == 'M' && letter4 == 'X');

int solveB(Iterable<String> input) {
  final grid = <(int x, int y), String>{};
  var maxX = 0;
  var maxY = 0;

  for (final (y, line) in input.indexed) {
    maxY = max(maxY, y);

    for (final (x, letter) in line.split('').indexed) {
      maxX = max(maxX, x);
      grid[(x, y)] = letter;
    }
  }

  var xmasCount = 0;

  for (var y = 0; y <= maxY; y++) {
    for (var x = 0; x <= maxX; x++) {
      if (grid[(x, y)] == 'M' &&
          grid[(x + 2, y)] == 'S' &&
          grid[(x + 1, y + 1)] == 'A' &&
          grid[(x, y + 2)] == 'M' &&
          grid[(x + 2, y + 2)] == 'S') {
        xmasCount++;
      }
      if (grid[(x, y)] == 'S' &&
          grid[(x + 2, y)] == 'S' &&
          grid[(x + 1, y + 1)] == 'A' &&
          grid[(x, y + 2)] == 'M' &&
          grid[(x + 2, y + 2)] == 'M') {
        xmasCount++;
      }
      if (grid[(x, y)] == 'M' &&
          grid[(x + 2, y)] == 'M' &&
          grid[(x + 1, y + 1)] == 'A' &&
          grid[(x, y + 2)] == 'S' &&
          grid[(x + 2, y + 2)] == 'S') {
        xmasCount++;
      }
      if (grid[(x, y)] == 'S' &&
          grid[(x + 2, y)] == 'M' &&
          grid[(x + 1, y + 1)] == 'A' &&
          grid[(x, y + 2)] == 'S' &&
          grid[(x + 2, y + 2)] == 'M') {
        xmasCount++;
      }
    }
  }

  return xmasCount;
}
