// --- Day 3: Mull It Over ---
// https://adventofcode.com/2024/day/3

int solveA(Iterable<String> input) {
  final regExp = RegExp(r'mul\((\d{1,3}),(\d{1,3})\)');
  var sum = 0;

  for (final match in input.expand(regExp.allMatches)) {
    final [arg1!, arg2!] = match.groups([1, 2]);
    sum += int.parse(arg1) * int.parse(arg2);
  }

  return sum;
}

int solveB(Iterable<String> input) {
  final regExp = RegExp(r"mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)");
  var mulEnabled = true;
  var sum = 0;

  for (final match in input.expand(regExp.allMatches)) {
    if (match[0] == "do()") {
      mulEnabled = true;
    } else if (match[0] == "don't()") {
      mulEnabled = false;
    } else if (mulEnabled) {
      final [arg1!, arg2!] = match.groups([1, 2]);
      sum += int.parse(arg1) * int.parse(arg2);
    }
  }

  return sum;
}
