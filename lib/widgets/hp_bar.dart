import 'package:flutter/material.dart';
import '../theme.dart';

class HpBar extends StatelessWidget {
  final int currentHp;
  final int maxHp;
  final String label;

  const HpBar({
    super.key,
    required this.currentHp,
    required this.maxHp,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final double ratio = maxHp == 0 ? 0 : (currentHp / maxHp).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurface,
                letterSpacing: 1.5,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: Stack(
            children: [
              Container(
                height: 14,
                width: double.infinity,
                color: const Color(0xFF081C24),
              ),
              FractionallySizedBox(
                widthFactor: ratio,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: scheme.secondary,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$currentHp/$maxHp XP',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurface,
                  letterSpacing: 1.5,
                ),
          ),
        ),
      ],
    );
  }
}