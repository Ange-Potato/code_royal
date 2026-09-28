class Question {
  final String prompt;
  final String code;
  final Map<String, String> choices; 
  final String correctAnswer;        
  final String explanation;
  final int difficulty;              

  const Question({
    required this.prompt,
    required this.code,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
    this.difficulty = 1,
  });
}