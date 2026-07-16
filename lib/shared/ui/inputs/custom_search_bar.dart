import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final VoidCallback? onTapClearIcon;
  final bool? showClearButton;
  final bool isBuyCar;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onTapClearIcon,
    this.showClearButton,
    required this.hintText,
    required this.isBuyCar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFF757575), size: 20),
          const Gap(AppSpacing.md),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: GoogleFonts.poppins(fontSize: 14, color: theme.colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
                border: InputBorder.none,
                // isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (isBuyCar) ...[
            if (showClearButton!)
              GestureDetector(
                onTap: onTapClearIcon,
                child: Icon(Icons.clear, color: Color(0xFF757575), size: 20),
              )
            else
              Icon(Icons.tune, color: Color(0xFF757575), size: 20),
          ],
        ],
      ),
    );
  }
}
