import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorFaqSection extends StatelessWidget {
  const VendorFaqSection({
    super.key,
    required this.faqs,
    required this.expandedFaqs,
    required this.onToggle,
  });

  final List<VendorFaqItemData> faqs;
  final Set<int> expandedFaqs;
  final void Function(int index) onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.profile_menu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.faqs,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.md),
        ...List.generate(
          faqs.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FaqTile(
              data: faqs[index],
              isExpanded: expandedFaqs.contains(index),
              onToggle: () => onToggle(index),
            ),
          ),
        ),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.data,
    required this.isExpanded,
    required this.onToggle,
  });

  final VendorFaqItemData data;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final bool hasAnswer = data.answer != null && data.answer!.isNotEmpty;
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: hasAnswer ? onToggle : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.question,
                    style: GoogleFonts.poppins(
                      color: theme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: hasAnswer && isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: hasAnswer && isExpanded
                        ? AppColors.secondary
                        : theme.onSurface,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          if (hasAnswer && isExpanded) ...[
            const Gap(AppSpacing.sm),
            Text(
              data.answer!,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class VendorFaqItemData {
  const VendorFaqItemData({required this.question, this.answer});

  final String question;
  final String? answer;
}
