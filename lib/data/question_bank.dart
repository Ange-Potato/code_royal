import 'dart:math';
import '../models/question.dart';

const List<Question> questionBank = [
  // ---- Difficulty 1: Easy ----
  Question(
    prompt: 'What does this loop print?',
    code: 'for (int i = 0; i < 3; i++)\n  print(i);',
    choices: {'A': '123', 'B': '012', 'C': '0123', 'D': '111'},
    correctAnswer: 'B',
    explanation: 'i starts at 0 and stops before 3, so it prints 0, 1, 2.',
    difficulty: 1,
  ),
  Question(
    prompt: 'What is the value of x?',
    code: 'int x = 5 + 3 * 2;',
    choices: {'A': '16', 'B': '11', 'C': '13', 'D': '10'},
    correctAnswer: 'B',
    explanation: 'Multiplication runs before addition: 3*2 = 6, then 5+6 = 11.',
    difficulty: 1,
  ),
  Question(
    prompt: 'Which keyword declares a constant in Dart?',
    code: '___ int maxHp = 100;',
    choices: {'A': 'var', 'B': 'final', 'C': 'const', 'D': 'static'},
    correctAnswer: 'C',
    explanation: 'const declares a compile-time constant.',
    difficulty: 1,
  ),
  Question(
    prompt: 'What type is this value?',
    code: 'var name = "Bug Lord";',
    choices: {'A': 'int', 'B': 'String', 'C': 'bool', 'D': 'double'},
    correctAnswer: 'B',
    explanation: 'Text inside quotes is a String.',
    difficulty: 1,
  ),

  // ---- Difficulty 2: Medium ----
  Question(
    prompt: 'What does this print?',
    code: 'for (int i = 0; i < 5; i++) {\n  if (i == 2) continue;\n  print(i);\n}',
    choices: {'A': '01234', 'B': '0134', 'C': '0123', 'D': '234'},
    correctAnswer: 'B',
    explanation: 'continue skips the body when i == 2, so 2 is not printed.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What is the length of this list?',
    code: 'var nums = [1, 2, 3, 4, 5];\nnums.removeWhere((n) => n.isEven);',
    choices: {'A': '5', 'B': '3', 'C': '2', 'D': '1'},
    correctAnswer: 'B',
    explanation: 'removeWhere drops 2 and 4, leaving [1, 3, 5].',
    difficulty: 2,
  ),
  Question(
    prompt: 'What does this function return?',
    code: 'int add(int a, int b) => a + b;\nadd(3, 4);',
    choices: {'A': '34', 'B': '7', 'C': '12', 'D': 'null'},
    correctAnswer: 'B',
    explanation: 'Arrow syntax returns a + b = 7.',
    difficulty: 2,
  ),

  // ---- Difficulty 3: Hard ----
  Question(
    prompt: 'What does this print?',
    code: 'var a = [1, 2, 3];\nvar b = a;\nb[0] = 99;\nprint(a[0]);',
    choices: {'A': '1', 'B': '99', 'C': '0', 'D': 'Error'},
    correctAnswer: 'B',
    explanation: 'Lists are reference types; b points to the same list as a.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What is the output?',
    code: 'int fact(int n) => n <= 1 ? 1 : n * fact(n - 1);\nprint(fact(4));',
    choices: {'A': '4', 'B': '12', 'C': '24', 'D': '16'},
    correctAnswer: 'C',
    explanation: '4 * 3 * 2 * 1 = 24.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What happens here?',
    code: 'var list = <int>[];\nlist[0] = 1;\nprint(list);',
    choices: {
      'A': 'Prints [1]',
      'B': 'Prints []',
      'C': 'Throws RangeError',
      'D': 'Throws TypeError',
    },
    correctAnswer: 'C',
    explanation: 'Assigning index 0 on an empty list is out of range.',
    difficulty: 3,
  ),
];

Question randomQuestion({int? maxDifficulty, Random? rng}) {
  final r = rng ?? Random();
  final pool = maxDifficulty == null
      ? questionBank
      : questionBank.where((q) => q.difficulty <= maxDifficulty).toList();
  return pool[r.nextInt(pool.length)];
}

List<Question> questionsByDifficulty(int difficulty) =>
    questionBank.where((q) => q.difficulty == difficulty).toList();