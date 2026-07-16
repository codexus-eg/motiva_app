import 'package:intl/intl.dart';

class TimeUtils {
  static String getRelativeTime(DateTime dateTime, {DateTime? now}) {
    final nowTime = now ?? DateTime.now();
    final diff = nowTime.difference(dateTime);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays <= 7) {
      return '${diff.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }

  static String getFutureTime(DateTime scheduledAt, {DateTime? now}) {
    final localScheduledAt = scheduledAt.toLocal();
    final nowTime = now ?? DateTime.now();
    final diff = localScheduledAt.difference(nowTime);

    if (diff.isNegative) {
      return 'Overdue';
    }

    if (diff.inMinutes < 60) {
      return 'In ${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      if (minutes == 0) {
        return 'In ${hours}h';
      }
      return 'In ${hours}h ${minutes}m';
    } else if (diff.inDays == 1) {
      return 'Tomorrow at ${DateFormat('h:mm a').format(localScheduledAt)}';
    } else if (diff.inDays < 7) {
      return DateFormat('EEEE').format(localScheduledAt);
    } else {
      return DateFormat('MMM d, h:mm a').format(localScheduledAt);
    }
  }

  static String formatScheduledTime(DateTime scheduledAt) {
    return DateFormat('MMM d, h:mm a').format(scheduledAt.toLocal());
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime.toLocal());
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime.toLocal());
  }

  static bool isToday(DateTime dateTime) {
    final localDt = dateTime.toLocal();
    final now = DateTime.now();
    return localDt.year == now.year &&
        localDt.month == now.month &&
        localDt.day == now.day;
  }

  static bool isTomorrow(DateTime dateTime) {
    final localDt = dateTime.toLocal();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return localDt.year == tomorrow.year &&
        localDt.month == tomorrow.month &&
        localDt.day == tomorrow.day;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    final localA = a.toLocal();
    final localB = b.toLocal();
    return localA.year == localB.year && localA.month == localB.month && localA.day == localB.day;
  }
}
