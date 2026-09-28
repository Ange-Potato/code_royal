import 'package:flutter/material.dart';
import '../theme.dart';

class BattleHpBar extends StatelessWidget {
  final int currentHp;
  final int maxHp;
  final Color fillColor;

  const BattleHpBar({
    super.key,
    required this.currentHp,
    required this.maxHp,
    this.fillColor = const Color(0xFFC1121F),
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final double ratio =
        maxHp == 0 ? 0 : (currentHp / maxHp).clamp(0.0, 1.0);

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            child: Stack(
              children: [
                Container(
                  height: 12,
                  width: double.infinity,
                  color: const Color(0xFF081C24),
                ),
                FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(height: 12, color: fillColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$currentHp/$maxHp',
          style: text.labelSmall?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}