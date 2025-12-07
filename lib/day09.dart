// --- Day 9: Disk Fragmenter ---
// https://adventofcode.com/2024/day/9

import 'dart:collection';

import 'package:collection/collection.dart';

int solveA(String input) {
  final disk = <int?>[];

  for (var i = 0, id = 0; i < input.length; i++) {
    var digit = int.parse(input[i]);

    if (i % 2 == 0) {
      for (var k = 0; k < digit; k++) {
        disk.add(id);
      }
      id++;
    } else {
      for (var k = 0; k < digit; k++) {
        disk.add(null);
      }
    }
  }

  // Cache the last found index since next search for free space can start
  // from here and be more efficient
  var freeSpaceIndex = 0;
  for (var i = disk.length - 1; i >= 0; i--) {
    if (disk[i] != null) {
      if ((freeSpaceIndex = disk.indexOf(null, freeSpaceIndex + 1)) >= i) {
        break;
      }

      disk.swap(i, freeSpaceIndex);
    }
  }

  return disk.whereType<int>().indexed.map((e) => e.$1 * e.$2).sum;
}

sealed class Block extends LinkedListEntry<Block> {
  int length;

  Block({required this.length});
}

final class DataBlock extends Block {
  int id;

  DataBlock({required this.id, required super.length});
}

final class FreeBlock extends Block {
  FreeBlock({required super.length});
}

int solveB(String input) {
  final disk = LinkedList<Block>();
  final dataBlocks = <DataBlock>[];

  // Read disk
  for (var i = 0, id = 0; i < input.length; i++) {
    var digit = int.parse(input[i]);

    if (i % 2 == 0) {
      final dataBlock = DataBlock(id: id++, length: digit);
      disk.add(dataBlock);
      dataBlocks.add(dataBlock);
    } else {
      disk.add(FreeBlock(length: digit));
    }
  }

  for (final dataBlock in dataBlocks.reversed) {
    final freeBlock = disk
        .takeWhile((block) => !identical(block, dataBlock))
        .whereType<FreeBlock>()
        .firstWhereOrNull((block) => block.length >= dataBlock.length);

    if (freeBlock == null) {
      continue;
    }

    if (dataBlock.next case FreeBlock freeBlock) {
      freeBlock.length += dataBlock.length;
    } else {
      dataBlock.insertAfter(FreeBlock(length: dataBlock.length));
    }
    dataBlock.unlink();

    freeBlock.insertBefore(dataBlock);
    freeBlock.length -= dataBlock.length;

    if (freeBlock.length == 0) {
      freeBlock.unlink();
    }
  }

  var sum = 0, index = 0;

  for (final block in disk) {
    if (block is DataBlock) {
      for (var i = 0; i < block.length; i++) {
        sum += block.id * index++;
      }
    } else {
      index += block.length;
    }
  }

  return sum;
}

bool notEmpty(int value) => value != -1;
