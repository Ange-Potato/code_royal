import 'package:flutter/material.dart';
import '../theme.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget content;
  final IconData? icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: scheme.onSurface, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: scheme.onSurface,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          content,
        ],
      ),
    );
  }
}