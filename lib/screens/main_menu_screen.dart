import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/header_title.dart';
import '../widgets/primary_button.dart';
import '../widgets/info_card.dart';
import '../widgets/hp_bar.dart';
import 'profile_screen.dart';
import '../data/enemy_bank.dart';
import '../data/question_bank.dart';
import 'battle_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  final enemy = randomEnemy();
                  final question = randomQuestion(maxDifficulty: 1);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BattleScreen(enemy: enemy, question: question),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Profile',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Quit',
                onPressed: () {},
              ),
              const Spacer(),
              InfoCard(
                title: 'Player Summary',
                icon: Icons.person_outline,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LVL: 5',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const HpBar(
                      currentHp: 340,
                      maxHp: 540,
                      label: 'HP',
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