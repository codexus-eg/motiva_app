import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final String? helperText;
  final Function()? onTap;
  final bool isDestructive;

  const SettingCard({
    super.key,
    required this.title,
    this.onTap,
    this.helperText,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface;
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (helperText != null) ...[
            Text(
              helperText!,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(AppSpacing.md),
          ],
          Icon(
            Icons.arrow_forward_ios,
            color: color,
            size: 16,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
