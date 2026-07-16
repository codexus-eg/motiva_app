import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorWalletStatsGridWidget extends StatelessWidget {
  final String totalSales;
  final double totalEarnings;
  final String averageRating;
  final String cancellationRate;

  const VendorWalletStatsGridWidget({
    super.key,
    this.totalSales = '0',
    this.totalEarnings = 0,
    this.averageRating = '0.00',
    this.cancellationRate = '0.0',
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.wallet.stats;
    final stats = [
      _WalletStat(value: totalSales.toString(), label: t.total_sales),
      _WalletStat(
        value: _formatEarnings(totalEarnings),
        label: t.total_earnings,
      ),
      _WalletStat(value: averageRating, label: t.average_rating),
      _WalletStat(value: '$cancellationRate%', label: t.cancellation_rate),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - 8) / 2;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stats
              .map(
                (stat) => SizedBox(
                  width: tileWidth,
                  child: _StatTile(stat: stat),
                ),
              )
              .toList(),
        );
      },
    );
  }

  String _formatEarnings(double earnings) {
    if (earnings >= 1000) {
      return '${(earnings / 1000).toStringAsFixed(1)}K';
    }
    return earnings.toStringAsFixed(0);
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final _WalletStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: 102,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 6,
            child: SvgPicture.asset('assets/icons/vendor_wallet_grid.svg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: GoogleFonts.mulish(
                  color: AppColors.secondary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                stat.label,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 11,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletStat {
  const _WalletStat({required this.value, required this.label});

  final String value;
  final String label;
}
