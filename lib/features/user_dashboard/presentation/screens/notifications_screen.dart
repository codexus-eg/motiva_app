import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String type; // 'order', 'offer', 'system'
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Booking Confirmed',
      body:
          'Your car wash service request has been accepted by Prime Car Wash. The provider will arrive shortly.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      type: 'order',
    ),
    NotificationItem(
      id: '2',
      title: 'Exclusive Offer for You!',
      body:
          'Get 25% off on your next car detailing service. Valid until this Sunday. Use coupon: DET25.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: 'offer',
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Operator Dispatched',
      body:
          'A recovery operator has been assigned and is heading to your location for the towing assistance.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: 'order',
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'App System Update',
      body:
          'We have updated our marketplace platform with exciting new chat features for vehicle bidding.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: 'system',
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'Special Promo Alert',
      body:
          'Get free towing service on orders above \$150. Tap here to explore participating vendors.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: 'offer',
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationItem> _getFilteredNotifications(int index) {
    if (index == 0) return _notifications; // All
    if (index == 1)
      return _notifications.where((n) => n.type == 'order').toList();
    if (index == 2)
      return _notifications.where((n) => n.type == 'offer').toList();
    return _notifications.where((n) => n.type == 'system').toList(); // System
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  String _timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    final t = Translations.of(
      context,
    ).user_dashboard.active_orders_preview.time_ago;
    if (difference.inMinutes < 60) {
      return t.minutes_ago.replaceAll('{n}', difference.inMinutes.toString());
    } else if (difference.inHours < 24) {
      return t.hours_ago.replaceAll('{n}', difference.inHours.toString());
    } else {
      return t.days_ago.replaceAll('{n}', difference.inDays.toString());
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'order':
        return const Color(0xFFECA553);
      case 'offer':
        return const Color(0xFF4CAF50);
      case 'system':
      default:
        return const Color(0xFF2196F3);
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'offer':
        return Icons.local_offer_outlined;
      case 'system':
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Gap(AppSpacing.md),
            _buildHeader(context),
            const Gap(AppSpacing.md),
            _buildTabs(theme),
            const Gap(AppSpacing.md),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(4, (index) {
                  final list = _getFilteredNotifications(index);
                  if (list.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildNotificationList(list);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.orange,
                size: 16,
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            Translations.of(context).user_dashboard.notifications.screen_title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 1.1,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              Translations.of(context).user_dashboard.notifications.read_all,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFECA553),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFFECA553),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelColor: theme.colorScheme.onSurface.withValues(
          alpha: 0.6,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        tabs: [
          Tab(
            text: Translations.of(context).user_dashboard.notifications.tab_all,
          ),
          Tab(
            text: Translations.of(
              context,
            ).user_dashboard.notifications.tab_orders,
          ),
          Tab(
            text: Translations.of(
              context,
            ).user_dashboard.notifications.tab_offers,
          ),
          Tab(
            text: Translations.of(
              context,
            ).user_dashboard.notifications.tab_system,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationItem> list) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final typeColor = _getTypeColor(item.type);
        final theme = Theme.of(context);

        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => _deleteNotification(item.id),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                item.isRead = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: item.isRead
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6)
                    : theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: item.isRead
                      ? Colors.transparent
                      : typeColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: item.isRead
                    ? null
                    : [
                        BoxShadow(
                          color: typeColor.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getTypeIcon(item.type),
                      color: typeColor,
                      size: 20,
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
                              item.title,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: item.isRead
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              _timeAgo(item.timestamp),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          item.body,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: item.isRead ? 0.6 : 0.85,
                            ),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              color: Colors.grey,
              size: 48,
            ),
          ),
          const Gap(AppSpacing.lg),
          Text(
            Translations.of(context).user_dashboard.notifications.empty.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            Translations.of(
              context,
            ).user_dashboard.notifications.empty.subtitle,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
        ],
      ),
    );
  }
}
