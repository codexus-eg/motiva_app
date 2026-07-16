import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/i18n/strings.g.dart';

import '../../domain/entities/vendor_product_analytics.dart';

class TopProductsBarChart extends StatelessWidget {
  final List<TopProductSales> data;

  const TopProductsBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_product_analytics;

    if (data.isEmpty) {
      return _buildEmptyState(theme, t.empty.no_product_sales_data);
    }

    final displayData = data.take(5).toList();
    final maxRevenue = displayData.map((e) => e.revenue).reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.charts.top_products,
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
          child: BarChart(
            BarChartData(
              maxY: maxRevenue * 1.2,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxRevenue / 4,
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
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= displayData.length) {
                        return const SizedBox.shrink();
                      }
                      final name = displayData[index].name;
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          name.length > 8 ? '${name.substring(0, 6)}..' : name,
                          style: TextStyle(
                            color: theme.onSurface.withValues(alpha: 0.7),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42,
                    interval: maxRevenue / 4,
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
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => theme.surface,
                  tooltipBorder: BorderSide(
                    color: theme.onSurface.withValues(alpha: 0.2),
                  ),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final product = displayData[groupIndex];
                    return BarTooltipItem(
                      '${product.name}\nKWD ${product.revenue.toStringAsFixed(2)}\n${t.charts.sales.replaceAll('{count}', product.salesCount.toString())}',
                      TextStyle(
                        color: theme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
              barGroups: displayData.asMap().entries.map((entry) {
                final index = entry.key;
                final product = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: product.revenue,
                      color: AppColors.primary,
                      width: 24,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  String _formatCompact(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
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
