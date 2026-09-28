import 'package:flutter/material.dart';
import 'pill_button.dart';
import '../theme.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String code;
  final TextEditingController? controller;
  final VoidCallback? onAttack;

  const QuestionCard({
    super.key,
    required this.question,
    required this.code,
    this.controller,
    this.onAttack,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: scheme.primary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question.toUpperCase(),
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: const Color(0xFF081C24),
              borderRadius: BorderRadius.circular(AppSpacing.xs),
            ),
            child: Text(
              code,
              style: text.labelSmall?.copyWith(
                color: scheme.onSurface,
                letterSpacing: 1,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: 180,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.characters,
              maxLength: 1,
              style: text.labelSmall?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: 'YOUR ANSWER...',
                hintStyle: text.labelSmall?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.4),
                  letterSpacing: 1,
                ),
                filled: true,
                fillColor: const Color(0xFF081C24),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PillButton(
            label: 'Attack!',
            onPressed: onAttack ?? () {},
          ),
        ],
      ),
    );
  }
}