import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/player_progress.dart';
import '../data/enemy_bank.dart';
import '../data/question_bank.dart';
import '../widgets/header_title.dart';
import '../widgets/primary_button.dart';
import '../widgets/info_card.dart';
import '../widgets/hp_bar.dart';
import 'battle_screen.dart';
import 'profile_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final PlayerProgress progress;
  final ValueChanged<PlayerProgress> onProgressUpdated;

  const MainMenuScreen({
    super.key,
    required this.progress,
    required this.onProgressUpdated,
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
              const HeaderTitle(
                title: 'Code Royal',
                subtitle: 'Code Battle RPG',
              ),
              const SizedBox(height: AppSpacing.lg * 2),

              PrimaryButton(
                label: 'Battle',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BattleScreen(
                        enemy: randomEnemy(),
                        progress: progress,
                        onProgressUpdated: onProgressUpdated,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Profile',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(progress: progress),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Quit',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Quit coming soon')),
                  );
                },
              ),
              const Spacer(),
              InfoCard(
                title: 'Player Summary',
                icon: Icons.person_outline,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LVL: ${progress.level}',
                      style: text.bodyMedium?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    HpBar(
                      currentHp: progress.xp,
                      maxHp: PlayerProgress.xpPerLevel,
                      label: 'XP',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}