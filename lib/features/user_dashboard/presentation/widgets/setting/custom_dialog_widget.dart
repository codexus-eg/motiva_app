import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  final String labelRightButton;
  final String labelLeftButton;
  final VoidCallback onTapRightButton;
  final VoidCallback onTapLeftButton;

  const CustomDialogWidget({
    super.key,
    required this.onTapRightButton,
    required this.onTapLeftButton,
    required this.labelRightButton,
    required this.labelLeftButton,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFDC8735), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTapRightButton,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      labelRightButton,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: GradientButton(
                    text: labelLeftButton,
                    onTap: onTapLeftButton,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
