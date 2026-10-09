import 'dart:math';
import '../models/question.dart';

const List<Question> questionBank = [
  // ============ EASY (difficulty 1) ============
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
  Question(
    prompt: 'What does 7 % 3 return?',
    correctAnswer: '1',
    explanation: '7 divided by 3 is 2 remainder 1.',
    difficulty: 1,
  ),
  Question(
    prompt: 'Which symbol starts a single-line comment in Dart?',
    correctAnswer: '//',
    explanation: 'Double slash begins a line comment.',
    difficulty: 1,
  ),
  Question(
    prompt: 'What keyword declares a variable that can be reassigned?',
    correctAnswer: 'var',
    explanation: 'var declares a mutable variable.',
    difficulty: 1,
  ),

  // ============ MEDIUM (difficulty 2) ============
  Question(
    prompt: 'What does this print?',
    code: 'for (int i = 0; i < 5; i++) {\n  if (i == 2) continue;\n  print(i);\n}',
    correctAnswer: '0134',
    explanation: 'continue skips the body when i == 2.',
    difficulty: 2,
  ),
  Question(
    prompt: 'How many elements remain in nums?',
    code: 'var nums = [1, 2, 3, 4, 5];\nnums.removeWhere((n) => n.isEven);',
    correctAnswer: '3',
    explanation: 'removeWhere drops 2 and 4, leaving 1, 3, 5.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What does add(3, 4) return?',
    code: 'int add(int a, int b) => a + b;',
    correctAnswer: '7',
    explanation: '3 + 4 = 7.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What is the length of "Code Royal"?',
    correctAnswer: '10',
    explanation: 'Count the characters including the space: 10.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What does nums.last return here?',
    code: 'var nums = [4, 8, 15, 16];',
    correctAnswer: '16',
    explanation: 'last returns the final element.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What is the type of [1, 2, 3]?',
    correctAnswer: 'List<int>',
    explanation: 'A list of ints is typed List<int>.',
    difficulty: 2,
  ),
  Question(
    prompt: 'What does "abc".toUpperCase() return?',
    correctAnswer: 'ABC',
    explanation: 'toUpperCase returns a new string in capitals.',
    difficulty: 2,
  ),

  // ============ HARD (difficulty 3) ============
  Question(
    prompt: 'What does a[0] print?',
    code: 'var a = [1, 2, 3];\nvar b = a;\nb[0] = 99;\nprint(a[0]);',
    correctAnswer: '99',
    explanation: 'Lists are reference types; b points to the same list as a.',
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
    explanation: 'Assigning index 0 on an empty list is out of range.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What does a ?? b return when a is null and b is 5?',
    code: 'int? a;\nvar b = 5;\nprint(a ?? b);',
    correctAnswer: '5',
    explanation: '?? returns the right side when the left is null.',
    difficulty: 3,
  ),
  Question(
    prompt: 'What does the spread operator do here?',
    code: 'var a = [1, 2];\nvar b = [0, ...a, 3];',
    correctAnswer: 'expands',
    explanation: 'The ... operator expands the list into the new list.',
    difficulty: 3,
  ),
];

class QuestionPicker {
  final Random _rng;
  final Set<String> _usedPrompts = {};

  QuestionPicker({Random? rng}) : _rng = rng ?? Random();

  Question? pick({required int difficulty}) {
    final atDifficulty = questionBank
        .where((q) => q.difficulty == difficulty)
        .where((q) => !_usedPrompts.contains(q.prompt))
        .toList();

    if (atDifficulty.isNotEmpty) {
      final q = atDifficulty[_rng.nextInt(atDifficulty.length)];
      _usedPrompts.add(q.prompt);
      return q;
    }

    final anyUnused = questionBank
        .where((q) => !_usedPrompts.contains(q.prompt))
        .toList();

    if (anyUnused.isEmpty) return null;

    final q = anyUnused[_rng.nextInt(anyUnused.length)];
    _usedPrompts.add(q.prompt);
    return q;
  }

  void reset() => _usedPrompts.clear();

  int get usedCount => _usedPrompts.length;
  int get totalCount => questionBank.length;
}