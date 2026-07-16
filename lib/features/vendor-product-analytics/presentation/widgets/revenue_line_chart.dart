import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/i18n/strings.g.dart';

import '../../domain/entities/vendor_product_analytics.dart';

class RevenueLineChart extends StatelessWidget {
  final List<RevenuePoint> data;

  const RevenueLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_product_analytics;

    if (data.isEmpty) {
      return _buildEmptyState(theme, t.empty.no_revenue_data);
    }

    final spots = _generateSpots();
    final maxRevenue = data
        .map((e) => e.revenue)
        .reduce((a, b) => a > b ? a : b);
    final minRevenue = data
        .map((e) => e.revenue)
        .reduce((a, b) => a < b ? a : b);
    final yPadding = (maxRevenue - minRevenue) * 0.2;
    final maxY = maxRevenue + yPadding;
    final minY = ((minRevenue - yPadding).clamp(0, double.infinity)).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.charts.revenue_over_time,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          height: 220,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: (spots.length - 1).toDouble(),
              minY: minY,
              maxY: maxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: (maxY - minY) / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: theme.onSurface.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: _computeInterval(spots.length),
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= data.length)
                        return const SizedBox.shrink();
                      final date = data[index].date;
                      return Text(
                        '${date.day}/${date.month}',
                        style: TextStyle(
                          color: theme.onSurface.withValues(alpha: 0.6),
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42,
                    interval: (maxY - minY) / 4,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        _formatCompact(value),
                        style: TextStyle(
                          color: theme.onSurface.withValues(alpha: 0.6),
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => theme.surface,
                  tooltipBorder: BorderSide(
                    color: theme.onSurface.withValues(alpha: 0.2),
                  ),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final index = spot.x.toInt();
                      final date = data[index].date;
                      return LineTooltipItem(
                        '${date.day}/${date.month}\n${_formatCurrency(spot.y)}',
                        TextStyle(
                          color: theme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: AppColors.primary,
                  barWidth: 3,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.primary.withValues(alpha: 0.15),
                  ),
                  spots: spots,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _generateSpots() {
    return data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.revenue);
    }).toList();
  }

  double _computeInterval(int length) {
    if (length <= 7) return 1;
    if (length <= 14) return 2;
    if (length <= 30) return 5;
    return 10;
  }

  String _formatCompact(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
  }

  String _formatCurrency(double value) {
    return 'KWD ${value.toStringAsFixed(2)}';
  }

  Widget _buildEmptyState(ColorScheme theme, String message) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          message,
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
