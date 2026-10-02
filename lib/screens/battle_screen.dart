import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/enemy.dart';
import '../models/question.dart';
import '../models/player_progress.dart';
import '../data/question_bank.dart';
import '../widgets/battle_hp_bar.dart';
import '../widgets/battle_log.dart';
import '../widgets/pill_button.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class BattleScreen extends StatefulWidget {
  final Enemy enemy;
  final Question initialQuestion;
  final PlayerProgress progress;
  final ValueChanged<PlayerProgress> onProgressUpdated;

  const BattleScreen({
    super.key,
    required this.enemy,
    required this.initialQuestion,
    required this.progress,
    required this.onProgressUpdated,
  });

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  static const int playerMaxHp = 100;
  static const int maxLogEntries = 3;

  late int enemyHp;
  late int playerHp;
  late Question currentQuestion;
  final TextEditingController _controller = TextEditingController();
  final List<String> _log = [];
  int correctCount = 0;
  int wrongCount = 0;

  int _damageFor(int difficulty) {
    switch (difficulty) {
      case 3:
        return 20; // hard
      case 2:
        return 15; // medium
      default:
        return 10; // easy
    }
  }

  @override
  void initState() {
    super.initState();
    enemyHp = widget.enemy.maxHp;
    playerHp = playerMaxHp;
    currentQuestion = widget.initialQuestion;
    _log.add('> Awaiting attack...');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _logEvent(String entry) {
    _log.insert(0, entry);
    if (_log.length > maxLogEntries) {
      _log.removeLast();
    }
  }

  void _handleAttack() {
    final raw = _controller.text.trim().toUpperCase();

    if (raw.isEmpty || !['A', 'B', 'C', 'D'].contains(raw)) {
      setState(() {
        _logEvent('> Type A, B, C, or D.');
      });
      return;
    }

    final isCorrect = raw == currentQuestion.correctAnswer;
    final damage = _damageFor(currentQuestion.difficulty);

    setState(() {
      if (isCorrect) {
        correctCount++;
        enemyHp = (enemyHp - damage).clamp(0, widget.enemy.maxHp);
        _logEvent('> Correct! -$damage HP to ${widget.enemy.name}.');
      } else {
        wrongCount++;
        playerHp = (playerHp - damage).clamp(0, playerMaxHp);
        _logEvent(
          '> Wrong! Answer was ${currentQuestion.correctAnswer}. -$damage HP.',
        );
      }
      _controller.clear();
    });

    FocusScope.of(context).unfocus();

    if (enemyHp <= 0 || playerHp <= 0) {
      _endBattle();
      return;
    }

    setState(() {
      currentQuestion = randomQuestion(
        maxDifficulty: (widget.progress.level ~/ 10) + 1,
      );
    });
  }

  void _endBattle() {
    final isVictory = enemyHp <= 0;
    final xpGained = correctCount * 30 + (isVictory ? 50 : 0);
    final score = correctCount * 100 + (isVictory ? 200 : 0);

    final updated = widget.progress.gainBattleRewards(
      xpGained: xpGained,
      scoreGained: score,
      won: isVictory,
    );
    widget.onProgressUpdated(updated);

    final navigator = Navigator.of(context);

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          isVictory: isVictory,
          enemyName: widget.enemy.name,
          level: updated.level,
          xpGained: xpGained,
          score: score,
          onRetry: () {
            navigator.pushReplacement(
              MaterialPageRoute(
                builder: (_) => BattleScreen(
                  enemy: widget.enemy,
                  initialQuestion: randomQuestion(
                    maxDifficulty: (updated.level ~/ 10) + 1,
                  ),
                  progress: updated,
                  onProgressUpdated: widget.onProgressUpdated,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PillButton(
                label: 'Exit',
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSpacing.md),

              Center(
                child: Image.asset(
                  widget.enemy.assetPath,
                  height: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.bug_report,
                    size: 120,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Text(
                widget.enemy.name.toUpperCase(),
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              BattleHpBar(currentHp: enemyHp, maxHp: widget.enemy.maxHp),

              const SizedBox(height: AppSpacing.md),

              QuestionCard(
                question: currentQuestion.prompt,
                code: currentQuestion.code,
                controller: _controller,
                onAttack: _handleAttack,
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'KNIGHT CODE',
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              BattleHpBar(currentHp: playerHp, maxHp: playerMaxHp),

              const SizedBox(height: AppSpacing.md),

              BattleLog(entries: _log),
            ],
          ),
        ),
      ),
    );
  }
}