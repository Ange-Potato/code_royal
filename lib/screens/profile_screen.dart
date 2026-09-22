import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/player_progress.dart';
import '../widgets/header_title.dart';
import '../widgets/profile_stat_card.dart';

class ProfileScreen extends StatelessWidget {
  final PlayerProgress progress;

  const ProfileScreen({
    super.key,
    this.progress = PlayerProgress.sample,
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
              const SizedBox(height: AppSpacing.md),
              const HeaderTitle(title: 'Player Profile'),
              const SizedBox(height: AppSpacing.lg),
              ProfileStatCard(
                icon: Icons.emoji_events,
                label: 'Levels:',
                value: '${progress.level}/${PlayerProgress.maxLevel}',
                accentColor: AppColors.levelYellow,
                progress: progress.levelProgress,
                footer: Text(
                  'Current Progress: ${progress.levelPercent}%',
                  textAlign: TextAlign.center,
                  style: text.labelSmall?.copyWith(
                    color: scheme.onPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ProfileStatCard(
                icon: Icons.menu_book,
                label: 'Experience:',
                value: '${progress.xp}/${PlayerProgress.xpPerLevel}',
                accentColor: AppColors.xpGreen,
                progress: progress.xpProgress,
                footer: Text(
                  'Next Level in ${progress.xpToNextLevel} XP',
                  textAlign: TextAlign.center,
                  style: text.labelSmall?.copyWith(
                    color: scheme.onPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ProfileStatCard(
                icon: Icons.shield,
                label: 'Battle Won:',
                value: '${progress.battlesWon}',
                accentColor: scheme.error,
                footer: const Padding(
                  padding: EdgeInsets.only(top: AppSpacing.xs),
                  child: Icon(
                    Icons.military_tech,
                    color: AppColors.levelYellow,
                    size: 32,
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: _BackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.secondary,
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Icon(Icons.arrow_back, color: scheme.onSecondary),
        ),
      ),
    );
  }
}