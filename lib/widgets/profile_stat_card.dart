import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final double? progress;
  final Widget? footer;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    this.progress,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(
          color: scheme.onPrimary.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 44, color: scheme.onPrimary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: text.labelSmall?.copyWith(
                        color: scheme.onPrimary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: text.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              child: Stack(
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: const Color(0xFF081C24),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress!.clamp(0.0, 1.0),
                    child: Container(height: 12, color: accentColor),
                  ),
                ],
              ),
            ),
          ],
          if (footer != null) ...[
            const SizedBox(height: AppSpacing.xs),
            footer!,
          ],
        ],
      ),
    );
  }
}