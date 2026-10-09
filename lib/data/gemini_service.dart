import 'dart:convert';
import 'dart:math';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/question.dart';

class GeminiService {
  static const String _apiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  bool get hasKey => _apiKey.isNotEmpty;

  static const List<String> _topics = [
    'variables and types',
    'control flow (if / switch)',
    'loops (for / while)',
    'collections (List / Map / Set)',
    'functions and arrow syntax',
    'classes and constructors',
    'inheritance and mixins',
    'null safety and ?. / ??',
    'string methods',
    'async / await and Future',
    'exceptions (try / catch)',
    'type inference and generics',
  ];

  Future<Question> generateQuestion({
    required int difficulty,
    List<String> previousPrompts = const [],
  }) async {
    if (!hasKey) throw StateError('Missing GEMINI_API_KEY.');

    final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(temperature: 1.2),
    );

    final label = switch (difficulty) {
      1 => 'easy',
      2 => 'medium',
      _ => 'hard',
    };

    final topic = _topics[Random().nextInt(_topics.length)];

    final avoid = previousPrompts.isEmpty
        ? '(none yet)'
        : previousPrompts.map((p) => '- $p').join('\n');

    final prompt = '''
Generate ONE $label Dart programming question for a learning game.

Topic to focus on: $topic.

Do NOT reuse or rephrase any of these prompts already asked in this session:
$avoid

Return ONLY valid JSON, no markdown, no code fences:
{
  "prompt": "short question text, no more than 12 words",
  "code": "a short code snippet (1-4 lines) or an empty string",
  "correctAnswer": "the exact answer the player types (1-3 words or a number or symbol)",
  "explanation": "one sentence explaining the answer"
}

Rules:
- The correctAnswer must be one word, one number, or one short symbol.
- It must be unambiguous and case-insensitively matchable.
- Difficulty: $label.
- Be creative. Vary the phrasing and the scenario from previous questions.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final raw = response.text ?? '';
    final data = jsonDecode(_extractJson(raw)) as Map<String, dynamic>;

    return Question(
      prompt: (data['prompt'] as String).trim(),
      code: (data['code'] as String? ?? '').trim(),
      correctAnswer: (data['correctAnswer'] as String).trim(),
      explanation: (data['explanation'] as String? ?? '').trim(),
      difficulty: difficulty,
    );
  }

  String _extractJson(String raw) {
    var s = raw.trim();
    if (s.startsWith('```')) {
      s = s.replaceFirst(RegExp(r'^```[a-zA-Z]*\n?'), '');
      s = s.replaceFirst(RegExp(r'```$'), '');
    }
    final start = s.indexOf('{');
    final end = s.lastIndexOf('}');
    if (start == -1 || end == -1) {
      throw const FormatException('Gemini returned no JSON.');
    }
    return s.substring(start, end + 1);
  }
}