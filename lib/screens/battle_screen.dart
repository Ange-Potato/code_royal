import 'dart:math';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/enemy.dart';
import '../models/question.dart';
import '../models/player_progress.dart';
import '../data/gemini_service.dart';
import '../data/question_bank.dart';
import '../widgets/battle_hp_bar.dart';
import '../widgets/battle_log.dart';
import '../widgets/pill_button.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class BattleScreen extends StatefulWidget {
  final Enemy enemy;
  final PlayerProgress progress;
  final ValueChanged<PlayerProgress> onProgressUpdated;

  const BattleScreen({
    super.key,
    required this.enemy,
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
  final TextEditingController _controller = TextEditingController();
  final List<String> _log = [];
  final GeminiService _gemini = GeminiService();
  final QuestionPicker _picker = QuestionPicker();
  final Random _rng = Random();
  final List<String> _askedPrompts = [];

  Question? _currentQuestion;
  bool _loadingQuestion = true;
  int correctCount = 0;
  int wrongCount = 0;

  int _damageFor(int difficulty) {
    switch (difficulty) {
      case 3:
        return 20;
      case 2:
        return 15;
      default:
        return 10;
    }
  }

  int _rollDifficulty() {
    final level = widget.progress.level;
    final roll = _rng.nextDouble();

    if (level < 10) {
      // 65% easy, 30% medium, 5% hard
      if (roll < 0.65) return 1;
      if (roll < 0.95) return 2;
      return 3;
    } else if (level < 20) {
      // 35% easy, 40% medium, 25% hard
      if (roll < 0.35) return 1;
      if (roll < 0.75) return 2;
      return 3;
    } else {
      // 15% easy, 35% medium, 50% hard
      if (roll < 0.15) return 1;
      if (roll < 0.50) return 2;
      return 3;
    }
  }

  @override
  void initState() {
    super.initState();
    enemyHp = widget.enemy.maxHp;
    playerHp = playerMaxHp;
    _log.add('> Awaiting attack...');
    _loadQuestion();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _logEvent(String entry) {
    _log.insert(0, entry);
    if (_log.length > maxLogEntries) _log.removeLast();
  }

  Future<void> _loadQuestion() async {
    setState(() => _loadingQuestion = true);

    final difficulty = _rollDifficulty();

    if (_gemini.hasKey) {
      try {
        final q = await _gemini.generateQuestion(
          difficulty: difficulty,
          previousPrompts: _askedPrompts,
        );
        if (!mounted) return;
        _askedPrompts.add(q.prompt);
        setState(() {
          _currentQuestion = q;
          _loadingQuestion = false;
        });
        return;
      } catch (e) {
        debugPrint('Gemini failed: $e');
        if (mounted) _logEvent('> Offline question (no AI).');
      }
    }

    var q = _picker.pick(difficulty: difficulty);

    if (q == null) {
      _picker.reset();
      q = _picker.pick(difficulty: difficulty);
      if (mounted) _logEvent('> Question bank cycled.');
    }

    if (!mounted) return;
    setState(() {
      _currentQuestion = q;
      _loadingQuestion = false;
    });
  }

  bool _answersMatch(String user, String correct) {
    final u = user.trim().toLowerCase();
    final c = correct.trim().toLowerCase();
    if (u == c) return true;
    final uNum = num.tryParse(u);
    final cNum = num.tryParse(c);
    if (uNum != null && cNum != null) return uNum == cNum;
    return false;
  }

  Future<void> _handleAttack() async {
    final q = _currentQuestion;
    if (q == null || _loadingQuestion) return;

    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      setState(() => _logEvent('> Type an answer first.'));
      return;
    }

    final isCorrect = _answersMatch(raw, q.correctAnswer);
    final damage = _damageFor(q.difficulty);

    setState(() {
      if (isCorrect) {
        correctCount++;
        enemyHp = (enemyHp - damage).clamp(0, widget.enemy.maxHp);
        _logEvent('> Correct! -$damage HP to ${widget.enemy.name}.');
      } else {
        wrongCount++;
        playerHp = (playerHp - damage).clamp(0, playerMaxHp);
        _logEvent('> Wrong! Answer: "${q.correctAnswer}". -$damage HP.');
      }
      _controller.clear();
      _currentQuestion = null;
    });

    FocusScope.of(context).unfocus();

    if (enemyHp <= 0 || playerHp <= 0) {
      _endBattle();
      return;
    }

    await _loadQuestion();
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

              if (_loadingQuestion || _currentQuestion == null)
                const _LoadingCard()
              else
                QuestionCard(
                  question: _currentQuestion!.prompt,
                  code: _currentQuestion!.code,
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

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: scheme.primary, width: 1.5),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'LOADING QUESTION...',
            style: text.labelSmall?.copyWith(
              color: scheme.onSurface,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}