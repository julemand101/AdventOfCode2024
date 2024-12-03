// --- Day 3: Mull It Over ---
// https://adventofcode.com/2024/day/3

int solveA(Iterable<String> input) {
  final regExp = RegExp(r'mul\((\d{1,3}),(\d{1,3})\)');
  var sum = 0;

  for (final match in input.expand(regExp.allMatches)) {
    sum += int.parse(match[1]!) * int.parse(match[2]!);
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
      sum += int.parse(match[1]!) * int.parse(match[2]!);
    }
  }

  return sum;
}
