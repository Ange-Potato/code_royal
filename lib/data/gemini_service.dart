import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/question.dart';

class GeminiService {
  static const String _apiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  bool get hasKey => _apiKey.isNotEmpty;

  Future<Question> generateQuestion({required int difficulty}) async {
    debugPrint('GeminiService: hasKey=$hasKey, keyLen=${_apiKey.length}');

    if (!hasKey) throw StateError('Missing GEMINI_API_KEY.');

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: _apiKey,
    );

    final label = switch (difficulty) {
      1 => 'easy',
      2 => 'medium',
      _ => 'hard',
    };

    final prompt = '''
Generate one $label Dart programming question for a learning game.

Return ONLY valid JSON (no markdown, no code fences):
{
  "prompt": "short question text, no more than 12 words",
  "code": "a short code snippet (1-4 lines) or an empty string",
  "correctAnswer": "the exact answer the player types (1-3 words or a number or symbol)",
  "explanation": "one sentence explaining the answer"
}

Rules:
- The correctAnswer must be short, unambiguous, and case-insensitive matchable.
- Difficulty: $label.
- Topic: Dart language, control flow, collections, functions, or OOP basics.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final raw = response.text ?? '';
    debugPrint('Gemini raw response: $raw');
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