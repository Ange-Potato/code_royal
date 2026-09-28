import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/header_title.dart';
import '../widgets/pill_button.dart';

class ResultScreen extends StatelessWidget {
  final bool isVictory;
  final String enemyName;
  final int level;
  final int xpGained;
  final int score;

  const ResultScreen({
    super.key,
    required this.isVictory,
    required this.enemyName,
    required this.level,
    required this.xpGained,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              HeaderTitle(
                title: isVictory ? 'Victory!' : 'Defeat',
                subtitle: isVictory
                    ? '$enemyName Defeated'
                    : 'Defeated by $enemyName',
              ),
              const SizedBox(height: AppSpacing.lg * 2),
              _ResultsCard(
                level: level,
                xpGained: xpGained,
                score: score,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PillButton(
                    label: 'Retry',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  PillButton(
                    label: 'Home',
                    onPressed: () =>
                        Navigator.of(context).popUntil((r) => r.isFirst),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultsCard extends StatelessWidget {
  final int level;
  final int xpGained;
  final int score;

  const _ResultsCard({
    required this.level,
    required this.xpGained,
    required this.score,
  });

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
        border: Border.all(color: scheme.primary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'BATTLE RESULTS',
              style: text.bodyMedium?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ResultRow(label: 'LEVEL', value: '$level'),
          const SizedBox(height: AppSpacing.sm),
          _ResultRow(label: 'XP GAINED', value: '+$xpGained'),
          const SizedBox(height: AppSpacing.sm),
          _ResultRow(label: 'SCORE', value: '$score'),
        ],
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;

  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: text.labelSmall?.copyWith(
            color: scheme.onSurface,
            letterSpacing: 2,
          ),
        ),
        Text(
          value,
          style: text.bodyMedium?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}