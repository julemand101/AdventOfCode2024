// --- Day 5: Print Queue ---
// https://adventofcode.com/2024/day/5

import 'package:collection/collection.dart';

int solveA(Iterable<String> input) =>
    getPageLists(
      input,
      getSorted: true,
    ).map((o) => o.pageList[o.pageList.length ~/ 2]).sum;

int solveB(Iterable<String> input) =>
    getPageLists(input, getSorted: false)
        .map(
          (o) =>
              o.pageList..sort((p1, p2) => comparePages(o.pageRules, p1, p2)),
        )
        .map((pageList) => pageList[pageList.length ~/ 2])
        .sum;

Iterable<({List<int> pageList, Map<int, Set<int>> pageRules})> getPageLists(
  Iterable<String> input, {
  required bool getSorted,
}) sync* {
  final pageOrderingRules = <int, Set<int>>{};

  var parsePageOrderingRules = true;
  for (final line in input) {
    if (line == '') {
      parsePageOrderingRules = false;
      continue;
    }

    if (parsePageOrderingRules) {
      final [partA, partB] = line.split('|');

      pageOrderingRules.update(
        int.parse(partA),
        (set) => set..add(int.parse(partB)),
        ifAbsent: () => {int.parse(partB)},
      );
    } else {
      if ([...line.split(',').map(int.parse)] case final pageList
          when pageList.isSorted(
                (page1, page2) => comparePages(pageOrderingRules, page1, page2),
              ) ==
              getSorted) {
        yield (pageList: pageList, pageRules: pageOrderingRules);
      }
    }
  }
}

int comparePages(Map<int, Set<int>> pageOrderingRules, int page1, int page2) {
  if (pageOrderingRules[page1] case final rules? when rules.contains(page2)) {
    return -1;
  }
  if (pageOrderingRules[page2] case final rules? when rules.contains(page1)) {
    return 1;
  }
  return 0;
}
