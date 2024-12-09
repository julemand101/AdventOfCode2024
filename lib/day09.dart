// --- Day 9: Disk Fragmenter ---
// https://adventofcode.com/2024/day/9

import 'package:collection/collection.dart';

int solveA(String input) {
  final disk = <int>[]; // -1 means empty
  var id = 0;
  var file = true;

  for (final diskMap in input.split('').map(int.parse)) {
    if (file) {
      for (var i = 0; i < diskMap; i++) {
        disk.add(id);
      }
      id++;
      file = false;
    } else {
      for (var i = 0; i < diskMap; i++) {
        disk.add(-1);
      }
      file = true;
    }
  }

  for (var i = disk.length - 1; i >= 0; i--) {
    if (disk[i] != -1) {
      final freeSpaceIndex = disk.indexOf(-1);

      if (freeSpaceIndex >= i) {
        break;
      }

      disk.swap(i, freeSpaceIndex);
    }
  }

  return disk.where((i) => i != -1).indexed.map((e) => e.$1 * e.$2).sum;
}

int solveB(String input) {
  final disk = <int>[]; // -1 means empty
  var id = 0;
  var file = true;

  for (final diskMap in input.split('').map(int.parse)) {
    if (file) {
      for (var i = 0; i < diskMap; i++) {
        disk.add(id);
      }
      id++;
      file = false;
    } else {
      for (var i = 0; i < diskMap; i++) {
        disk.add(-1);
      }
      file = true;
    }
  }

  bigLoop:
  while (--id >= 0) {
    final startBlock = disk.indexOf(id);
    final stopBlock = disk.lastIndexOf(id);
    final sizeOfBlock = stopBlock - startBlock + 1;

    var freeIndexStart = 0;
    var freeIndexStop = 0;
    var freeSpaceBlockSize = 0;

    while (freeSpaceBlockSize < sizeOfBlock) {
      freeIndexStart = disk.indexOf(-1, freeIndexStop + 1);
      freeIndexStop = disk.indexWhere(notEmpty, freeIndexStart + 1);

      if (freeIndexStart == -1 ||
          freeIndexStop == -1 ||
          freeIndexStart > startBlock) {
        continue bigLoop;
      }

      freeSpaceBlockSize = freeIndexStop - freeIndexStart;
    }

    for (var i = 0; i < sizeOfBlock; i++) {
      disk.swap(startBlock + i, freeIndexStart + i);
    }
  }

  return disk.indexed.map((e) => e.$2 == -1 ? 0 : e.$1 * e.$2).sum;
}

bool notEmpty(int value) => value != -1;
