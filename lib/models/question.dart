class Question {
  final String prompt;
  final String code;
  final String correctAnswer;
  final String explanation;
  final int difficulty; // 1 easy, 2 medium, 3 hard

  const Question({
    required this.prompt,
    this.code = '',
    required this.correctAnswer,
    this.explanation = '',
    this.difficulty = 1,
  });
}