import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    if (screen.width < 500) return child;

    return ColoredBox(
      color: const Color(0xFF0A0A0A),
      child: Center(
        child: Container(
          width: 390,
          height: 844,
          decoration: BoxDecoration(
            color: const Color(0xFF081C24),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: const Color(0xFF2A2A2A), width: 8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 40,
                spreadRadius: 8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: const Size(390, 844),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}