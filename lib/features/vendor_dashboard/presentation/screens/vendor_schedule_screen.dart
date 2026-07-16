import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/presentation/providers/vendor_orders_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app/core/theme/spacing.dart';

class VendorScheduleScreen extends ConsumerStatefulWidget {
  const VendorScheduleScreen({super.key});

  @override
  ConsumerState<VendorScheduleScreen> createState() =>
      _VendorScheduleScreenState();
}

class _VendorScheduleScreenState extends ConsumerState<VendorScheduleScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final calendarDataAsync = ref.watch(
      vendorCalendarProvider((
        year: _focusedDay.year,
        month: _focusedDay.month,
      )),
    );
    final allOrdersAsync = ref.watch(vendorOrdersProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          tooltip: SemanticLabels.backButton,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.vendor_dashboard.schedule.screen_title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildCalendar(calendarDataAsync),
            const Gap(AppSpacing.md),
            Expanded(
              child: allOrdersAsync.when(
                data: (orders) => _buildOrdersForDay(orders),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text(
                    t.vendor_dashboard.schedule.error_loading,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(AsyncValue calendarDataAsync) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TableCalendar<dynamic>(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          formatButtonTextStyle: TextStyle(color: AppColors.primary),
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          titleCentered: true,
          formatButtonVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
          weekendStyle: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
          weekendTextStyle: TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          todayDecoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          outsideDaysVisible: false,
        ),
        eventLoader: (day) {
          return calendarDataAsync.when(
            data: (calendarData) {
              final dateKey = DateFormat('yyyy-MM-dd').format(day);
              final dayData = calendarData.days[dateKey];
              if (dayData != null && dayData.totalOrders > 0) {
                return List.generate(dayData.totalOrders, (index) => {});
              }
              return [];
            },
            loading: () => [],
            error: (_, _) => [],
          );
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) return null;

            return calendarDataAsync.when(
              data: (calendarData) {
                final dateKey = DateFormat('yyyy-MM-dd').format(day);
                final dayData = calendarData.days[dateKey];
                if (dayData == null) return null;

                return Positioned(
                  bottom: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (dayData.pendingOrders > 0)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (dayData.acceptedOrders > 0)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (dayData.totalOrders >
                          dayData.pendingOrders + dayData.acceptedOrders)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                );
              },
              loading: () => null,
              error: (_, _) => null,
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }

  Widget _buildOrdersForDay(List<VendorOrder> orders) {
    final selectedDate = _selectedDay ?? DateTime.now();
    final selectedDateStart = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final selectedDateEnd = selectedDateStart.add(const Duration(days: 1));

    final scheduledOrders = orders.where((order) {
      if (order.scheduledAt == null) return false;
      final localScheduled = order.scheduledAt!.toLocal();
      return localScheduled.isAfter(selectedDateStart) &&
          localScheduled.isBefore(selectedDateEnd);
    }).toList();

    scheduledOrders.sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));

    if (scheduledOrders.isEmpty) {
      return _buildEmptyState(selectedDate);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, MMMM d').format(selectedDate),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '${scheduledOrders.length} ${scheduledOrders.length == 1 ? t.vendor_dashboard.schedule.appointment_singular : t.vendor_dashboard.schedule.appointment_plural}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: scheduledOrders.length,
            separatorBuilder: (_, _) => const Gap(AppSpacing.md),
            itemBuilder: (context, index) {
              return _ScheduledOrderCard(order: scheduledOrders[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(DateTime date) {
    final t = Translations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, color: Colors.grey[600], size: 64),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.schedule.no_appointments,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            t.vendor_dashboard.schedule.no_scheduled_for_date.replaceAll(
              '{date}',
              DateFormat('MMMM d').format(date),
            ),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ScheduledOrderCard extends StatelessWidget {
  final VendorOrder order;

  const _ScheduledOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VendorRequestDetailsScreen(orderId: order.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D35),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getStatusColor().withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: _getStatusColor(),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.jm().format(order.scheduledAt!.toLocal()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      _buildStatusBadge(context),
                    ],
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    order.serviceName ??
                        t.vendor_dashboard.schedule.service_fallback,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    order.customerName ??
                        t.vendor_dashboard.schedule.customer_fallback,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 24),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (order.status) {
      case 'pending_acceptance':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'en_route':
        return Colors.lightBlue;
      case 'arrived':
        return Colors.teal;
      case 'in_progress':
        return Colors.indigo;
      case 'completed':
        return Colors.green;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(BuildContext context) {
    final t = Translations.of(context);
    String text;
    Color color;

    switch (order.status) {
      case 'pending_acceptance':
        text = t.vendor_dashboard.schedule.status_pending;
        color = Colors.orange;
        break;
      case 'accepted':
        text = t.vendor_dashboard.schedule.status_accepted;
        color = Colors.blue;
        break;
      case 'en_route':
        text = t.vendor_dashboard.schedule.status_en_route;
        color = Colors.lightBlue;
        break;
      case 'arrived':
        text = t.vendor_dashboard.schedule.status_arrived;
        color = Colors.teal;
        break;
      case 'in_progress':
        text = t.vendor_dashboard.schedule.status_active;
        color = Colors.indigo;
        break;
      case 'completed':
        text = t.vendor_dashboard.schedule.status_done;
        color = Colors.green;
        break;
      case 'cancelled':
      case 'rejected':
        text = t.vendor_dashboard.schedule.status_cancelled;
        color = Colors.red;
        break;
      default:
        text = t.vendor_dashboard.schedule.status_unknown;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
