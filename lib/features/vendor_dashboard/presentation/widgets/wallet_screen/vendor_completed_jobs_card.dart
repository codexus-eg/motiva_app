import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';

class VendorCompletedJobsCard extends StatelessWidget {
  final List<VendorOrder>? orders;

  const VendorCompletedJobsCard({super.key, this.orders});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.onSurface.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 30,
          minY: 0,
          maxY: 200,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 50,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.onSurface.withValues(alpha: 0.15),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}k',
                    style: TextStyle(
                      color: theme.onSurface.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: theme.onSurface.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              color: theme.onSurface,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: _generateSpots(orders),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots(List<VendorOrder>? orders) {
    if (orders == null || orders.isEmpty) {
      return [const FlSpot(0, 0)];
    }

    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final countsByDay = <int, int>{};

    for (var i = 1; i <= daysInMonth; i++) {
      countsByDay[i] = 0;
    }

    for (final order in orders) {
      final completedAt = order.completedAt;
      if (completedAt != null &&
          completedAt.year == now.year &&
          completedAt.month == now.month) {
        final day = completedAt.day;
        countsByDay[day] = (countsByDay[day] ?? 0) + 1;
      }
    }

    return countsByDay.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
        .toList()
      ..sort((a, b) => a.x.compareTo(b.x));
  }
}
