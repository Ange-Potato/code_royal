import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/enemy.dart';
import '../models/question.dart';
import '../widgets/battle_hp_bar.dart';
import '../widgets/battle_log.dart';
import '../widgets/pill_button.dart';
import '../widgets/question_card.dart';

class BattleScreen extends StatelessWidget {
  final Enemy enemy;
  final Question question;

  const BattleScreen({
    super.key,
    required this.enemy,
    required this.question,
  });

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
              // Exit
              PillButton(
                label: 'Exit',
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSpacing.md),

              // Enemy image
              Center(
                child: Image.asset(
                  enemy.assetPath,
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

              // Enemy name + HP (static values for now)
              Text(
                enemy.name.toUpperCase(),
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              BattleHpBar(currentHp: 93, maxHp: enemy.maxHp),

              const SizedBox(height: AppSpacing.md),

              // Question
              QuestionCard(
                question: question.prompt,
                code: question.code,
                onAttack: () {},
              ),

              const SizedBox(height: AppSpacing.lg),

              // Player name + HP (static)
              Text(
                'KNIGHT CODE',
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const BattleHpBar(currentHp: 67, maxHp: 100),

              const SizedBox(height: AppSpacing.md),

              // Log
              const BattleLog(entries: ['> Awaiting attack...']),
            ],
          ),
        ),
      ),
    );
  }
}