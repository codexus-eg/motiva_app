import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';

class NotificationPreferencesState {
  final bool orderUpdates;
  final bool promotions;

  const NotificationPreferencesState({
    this.orderUpdates = true,
    this.promotions = true,
  });

  NotificationPreferencesState copyWith({
    bool? orderUpdates,
    bool? promotions,
  }) {
    return NotificationPreferencesState(
      orderUpdates: orderUpdates ?? this.orderUpdates,
      promotions: promotions ?? this.promotions,
    );
  }
}

class NotificationPreferencesNotifier
    extends StateNotifier<NotificationPreferencesState> {
  NotificationPreferencesNotifier({required String keyPrefix})
    : _keyPrefix = keyPrefix,
      super(const NotificationPreferencesState()) {
    _load();
  }

  final String _keyPrefix;

  String get _keyOrderUpdates => '${_keyPrefix}_notif_order_updates';
  String get _keyPromotions => '${_keyPrefix}_notif_promotions';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = NotificationPreferencesState(
      orderUpdates: prefs.getBool(_keyOrderUpdates) ?? true,
      promotions: prefs.getBool(_keyPromotions) ?? true,
    );
  }

  Future<void> setOrderUpdates(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOrderUpdates, value);
    state = state.copyWith(orderUpdates: value);
  }

  Future<void> setPromotions(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyPromotions, value);
    state = state.copyWith(promotions: value);
  }
}

final notificationPreferencesProvider =
    StateNotifierProvider<
      NotificationPreferencesNotifier,
      NotificationPreferencesState
    >((ref) {
      final authAsync = ref.watch(authNotifierProvider);
      final prefix = switch (authAsync) {
        AsyncData(:final value) when value is AuthAuthenticated =>
          value.user.role.name,
        _ => 'customer',
      };
      return NotificationPreferencesNotifier(keyPrefix: prefix);
    });
