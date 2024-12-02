// --- Day 2: Red-Nosed Reports ---
// https://adventofcode.com/2024/day/2

int solveA(Iterable<String> input) =>
    input.map((line) => line.split(' ').map(int.parse)).where(isValid).length;

int solveB(Iterable<String> input) =>
    input.map((line) => line.split(' ').map(int.parse)).where((report) {
      if (isValid(report)) {
        return true;
      }

      for (var i = 0; i < report.length; i++) {
        if (isValid(report, skipLevel: i)) {
          return true;
        }
      }

      return false;
    }).length;

bool isValid(Iterable<int> levels, {int skipLevel = -1}) {
  int? lastValue;
  bool? increasing;

  for (final (index, value) in levels.indexed) {
    if (index == skipLevel) {
      continue;
    }

    if (lastValue == null) {
      lastValue = value;
      continue;
    }

    if ((value - lastValue).abs() > 3 || value == lastValue) {
      return false;
    }

    if (increasing == null) {
      increasing = value > lastValue;
      lastValue = value;
      continue;
    }

    if (increasing && value < lastValue || !increasing && value > lastValue) {
      return false;
    }

    lastValue = value;
  }

  return true;
}
