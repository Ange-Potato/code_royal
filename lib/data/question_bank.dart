import 'dart:math';
import '../models/question.dart';

const List<Question> questionBank = [
  // Easy
  Question(
    prompt: 'What does this loop print?',
    code: 'for (int i = 0; i < 3; i++)\n  print(i);',
    correctAnswer: '012',
    explanation: 'i goes 0, 1, 2.',
    difficulty: 1,
  ),
  Question(
    prompt: 'What is the value of x?',
    code: 'int x = 5 + 3 * 2;',
    correctAnswer: '11',
    explanation: 'Multiplication first: 3*2 = 6, then 5+6 = 11.',
    difficulty: 1,
  ),
  Question(
    prompt: 'Which keyword declares a compile-time constant in Dart?',
    correctAnswer: 'const',
    explanation: 'const is a compile-time constant.',
    difficulty: 1,
  ),
  Question(
    prompt: 'What type is the value "Bug Lord"?',
    correctAnswer: 'String',
    explanation: 'Text in quotes is a String.',
    difficulty: 1,
  ),

  // Medium
  Question(
    prompt: 'What does this print?',
    code: 'for (int i = 0; i < 5; i++) {\n  if (i == 2) continue;\n  print(i);\n}',
    correctAnswer: '0134',
    explanation: 'continue skips i == 2.',
    difficulty: 2,
  ),
  Question(
    prompt: 'How many elements remain in nums?',
    code: 'var nums = [1, 2, 3, 4, 5];\nnums.removeWhere((n) => n.isEven);',
    correctAnswer: '3',
    explanation: 'Only 1, 3, 5 remain.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What does add(3, 4) return?',
    code: 'int add(int a, int b) => a + b;',
    correctAnswer: '7',
    explanation: '3 + 4 = 7.',
    difficulty: 2,
  ),

  // Hard
  Question(
    prompt: 'What does a[0] print?',
    code: 'var a = [1, 2, 3];\nvar b = a;\nb[0] = 99;\nprint(a[0]);',
    correctAnswer: '99',
    explanation: 'Lists are reference types.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What does fact(4) return?',
    code: 'int fact(int n) => n <= 1 ? 1 : n * fact(n - 1);',
    correctAnswer: '24',
    explanation: '4 * 3 * 2 * 1 = 24.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What error is thrown?',
    code: 'var list = <int>[];\nlist[0] = 1;',
    correctAnswer: 'RangeError',
    explanation: 'Index 0 on an empty list is out of range.',
    difficulty: 3,
  ),
];

Question randomQuestion({int maxDifficulty = 1, Random? rng}) {
  final r = rng ?? Random();
  final pool =
      questionBank.where((q) => q.difficulty <= maxDifficulty).toList();
  return pool[r.nextInt(pool.length)];
}