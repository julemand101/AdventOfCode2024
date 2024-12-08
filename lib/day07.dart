// --- Day 7: Bridge Repair ---
// https://adventofcode.com/2024/day/7

int solveA(Iterable<String> input) => solve(input, partB: false);
int solveB(Iterable<String> input) => solve(input, partB: true);

int solve(Iterable<String> input, {required bool partB}) {
  var totalCalibrationResult = 0;

  for (final line in input) {
    final [testValueString, rest] = line.split(': ');
    final testValue = int.parse(testValueString);
    final numbers = [...rest.split(' ').map(int.parse)];

    if (tryOperators(numbers, testValue, partB: partB)) {
      totalCalibrationResult += testValue;
    }
  }

  return totalCalibrationResult;
}

bool tryOperators(
  List<int> numbers,
  int target, {
  int result = 0,
  int pos = 0,
  required bool partB,
}) {
  if (result > target) {
    return false;
  }
  if (pos == numbers.length) {
    return target == result;
  }
  return tryOperators(
        numbers,
        target,
        result: numbers[pos] + result,
        pos: pos + 1,
        partB: partB,
      ) ||
      tryOperators(
        numbers,
        target,
        result: numbers[pos] * result,
        pos: pos + 1,
        partB: partB,
      ) ||
      (partB &&
          tryOperators(
            numbers,
            target,
            result: int.parse('$result${numbers[pos]}'),
            pos: pos + 1,
            partB: partB,
          ));
}
