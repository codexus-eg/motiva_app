import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/i18n/strings.g.dart' show Translations;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorAvailabilityCard extends StatefulWidget {
  final VendorProfile profile;
  final bool isUpdating;
  final Function(bool) onAvailabilityChanged;
  final Function(int) onCapacityChanged;

  const VendorAvailabilityCard({
    super.key,
    required this.profile,
    required this.isUpdating,
    required this.onAvailabilityChanged,
    required this.onCapacityChanged,
  });

  @override
  State<VendorAvailabilityCard> createState() => _VendorAvailabilityCardState();
}

class _VendorAvailabilityCardState extends State<VendorAvailabilityCard> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onCapacityChanged(int value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      widget.onCapacityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.availability_capacity;

    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.title,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(AppSpacing.md),
          _buildAvailabilityRow(theme, context),
          const Gap(AppSpacing.md),
          _buildCapacityRow(theme, context),
        ],
      ),
    );
  }

  Widget _buildAvailabilityRow(ColorScheme theme, BuildContext context) {
    final t = Translations.of(
      context,
    ).home.vendor.availability_capacity.availability;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.profile.isAvailable
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.profile.isAvailable ? Icons.check_circle : Icons.cancel,
              color: widget.profile.isAvailable ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.title,
                  style: GoogleFonts.poppins(
                    color: theme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.profile.isAvailable ? t.available : t.not_available,
                  style: GoogleFonts.poppins(
                    color: theme.onSurface.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (widget.isUpdating)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            )
          else
            Switch.adaptive(
              value: widget.profile.isAvailable,
              onChanged: widget.onAvailabilityChanged,
              activeColor: AppColors.green,
            ),
        ],
      ),
    );
  }

  Widget _buildCapacityRow(ColorScheme theme, BuildContext context) {
    final t = Translations.of(
      context,
    ).home.vendor.availability_capacity.capacity;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.work_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.title,
                      style: GoogleFonts.poppins(
                        color: theme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      t.description,
                      style: GoogleFonts.poppins(
                        color: theme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isUpdating)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.profile.orderCapacity}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const Gap(AppSpacing.md),
          Slider.adaptive(
            value: widget.profile.orderCapacity.toDouble(),
            min: 1,
            max: 50,
            divisions: 49,
            onChanged: widget.isUpdating
                ? null
                : (value) => _onCapacityChanged(value.toInt()),
            activeColor: AppColors.primary,
            inactiveColor: theme.onSurface.withValues(alpha: 0.2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1',
                style: GoogleFonts.poppins(
                  color: theme.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              Text(
                '25',
                style: GoogleFonts.poppins(
                  color: theme.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              Text(
                '50',
                style: GoogleFonts.poppins(
                  color: theme.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
