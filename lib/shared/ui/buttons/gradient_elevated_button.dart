import 'package:app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class GradientElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final double? width;
  final double height;
  final IconData? icon;
  final IconData? trailingIcon;
  final TextStyle? textStyle;

  const GradientElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.width,
    this.height = 56,
    this.icon,
    this.trailingIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isPrimary
                ? const [AppColors.primary, AppColors.secondary]
                : [theme.primaryContainer, theme.primaryContainer],
          ),
          border: isPrimary
              ? null
              : Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: AppColors.white, size: 20),
                      const Gap(AppSpacing.sm),
                    ],
                    Text(
                      text,
                      style:
                          textStyle ??
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isPrimary
                                ? AppColors.white
                                : theme.onSurface,
                          ),
                    ),
                    if (trailingIcon != null) ...[
                      const Gap(AppSpacing.sm),
                      Icon(trailingIcon, color: AppColors.white, size: 20),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
