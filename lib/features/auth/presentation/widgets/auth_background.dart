import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool showLogo;

  const AuthBackground({super.key, required this.child, this.showLogo = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/auth_bg.png', fit: BoxFit.cover),
          ),
          // Dark Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.15)),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                if (showLogo) ...[
                  const Gap(AppSpacing.lg),
                  Image.asset(
                    'assets/images/motiva_logo.png',
                    height: 80, // Adjust based on design
                  ),
                  const Gap(AppSpacing.lg),
                ],
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
