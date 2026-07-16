import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:app/core/theme/spacing.dart';

class OrderDetailSection extends StatelessWidget {
  final String title;
  final IconData? icon;
  final List<Widget> children;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const OrderDetailSection({
    super.key,
    required this.title,
    this.icon,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: const Color(0xFFFE8C00), size: 20),
                const Gap(AppSpacing.sm),
              ],
              Text(
                title,
                style: TextStyle(
                  color: theme.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          ...children,
        ],
      ),
    );
  }
}

class OrderInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  final Widget? trailing;

  const OrderInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: theme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const Gap(AppSpacing.sm),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              color: valueColor ?? theme.onSurface,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        if (trailing != null) ...[
          const Gap(AppSpacing.sm),
          trailing!,
        ],
      ],
    );
  }
}
