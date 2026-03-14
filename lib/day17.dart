// --- Day 17: Chronospatial Computer ---
// https://adventofcode.com/2024/day/17

import 'dart:math';

String solveA(Iterable<String> input) {
  var registerA = 0;
  var registerB = 0;
  var registerC = 0;
  final program = <int>[];

  // Parse input
  for (final line in input) {
    if (line.startsWith('Register A: ')) {
      registerA = int.parse(line.split('Register A: ')[1]);
    } else if (line.startsWith('Register B: ')) {
      registerB = int.parse(line.split('Register B: ')[1]);
    } else if (line.startsWith('Register C: ')) {
      registerC = int.parse(line.split('Register C: ')[1]);
    } else if (line.startsWith('Program: ')) {
      program.addAll(line.split('Program: ')[1].split(',').map(int.parse));
    }
  }

  return solve(registerA, registerB, registerC, program).join(',');
}

int solveB(Iterable<String> input) {
  final program = <int>[];

  // Parse input
  for (final line in input) {
    if (line.startsWith('Program: ')) {
      program.addAll(line.split('Program: ')[1].split(',').map(int.parse));
    }
  }

  loop1:
  for (var registerA = 0; registerA < 100000000000; registerA++) {
    var pos = 0;

    if (registerA % 1000000 == 0) {
      print(registerA);
    }

    for (final outputValue in solve(registerA, 0, 0, program)) {
      if (pos >= program.length) {
        continue loop1;
      }
      if (program[pos++] != outputValue) {
        continue loop1;
      }
    }

    if (pos == program.length) {
      return registerA;
    }
  }

  return 0;
}

Iterable<int> solve(int regA, int regB, int regC, List<int> program) sync* {
  var registerA = regA;
  var registerB = regB;
  var registerC = regC;

  int comboOperand(int value) => switch (value) {
    0 || 1 || 2 || 3 => value,
    4 => registerA,
    5 => registerB,
    6 => registerC,
    var value => throw Exception('Not valid value: $value'),
  };

  var instructionCounter = 0;

  while (instructionCounter >= 0 && instructionCounter < program.length) {
    switch (program[instructionCounter++]) {
      // adv - division
      case 0:
        final numerator = registerA;
        final denominator = pow(2, comboOperand(program[instructionCounter++]));
        registerA = numerator ~/ denominator;

      // bxl - bitwise XOR
      case 1:
        registerB = registerB ^ program[instructionCounter++];

      // bst - combo operand modulo 8
      case 2:
        registerB = comboOperand(program[instructionCounter++]) % 8;

      // jnz - jump if not zero
      case 3:
        if (registerA == 0) {
          instructionCounter++;
        } else {
          instructionCounter = program[instructionCounter++];
        }

      // bxc - bitwise XOR of register B and register C
      case 4:
        registerB = registerB ^ registerC;
        instructionCounter++;

      // out - output combo operand modulo 8
      case 5:
        yield comboOperand(program[instructionCounter++]) % 8;

      // bdv - adv instruction but result is stored in the B register
      case 6:
        final numerator = registerA;
        final denominator = pow(2, comboOperand(program[instructionCounter++]));
        registerB = numerator ~/ denominator;

      // cdv - adv instruction but result is stored in the C register
      case 7:
        final numerator = registerA;
        final denominator = pow(2, comboOperand(program[instructionCounter++]));
        registerC = numerator ~/ denominator;

      case var instruction:
        throw Exception('Unknown instruction: $instruction');
    }
  }
}
