import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:app/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:app/features/wallet/domain/entities/payout_request.dart';
import 'package:app/features/wallet/domain/entities/payout_requests_paginated.dart';
import 'package:app/features/wallet/domain/entities/vendor_dashboard_stats.dart';
import 'package:app/features/wallet/domain/entities/wallet_balance.dart';
import 'package:app/features/wallet/domain/entities/wallet_transactions_paginated.dart';
import 'package:app/features/wallet/domain/failures/wallet_failure.dart';
import 'package:app/features/wallet/domain/repositories/wallet_repository.dart';

class WalletTransactionsFilter {
  final String? type;
  final String? referenceType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;
  final int limit;

  const WalletTransactionsFilter({
    this.type,
    this.referenceType,
    this.fromDate,
    this.toDate,
    this.page = 1,
    this.limit = 20,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTransactionsFilter &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          referenceType == other.referenceType &&
          fromDate == other.fromDate &&
          toDate == other.toDate &&
          page == other.page &&
          limit == other.limit;

  @override
  int get hashCode =>
      Object.hash(type, referenceType, fromDate, toDate, page, limit);
}

final walletRemoteDataSourceProvider = Provider<WalletRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WalletRemoteDataSourceImpl(dioClient);
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  final remoteDataSource = ref.watch(walletRemoteDataSourceProvider);
  return WalletRepositoryImpl(remoteDataSource);
});

final walletBalanceProvider = FutureProvider<WalletBalance>((ref) async {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getBalance();
});

final walletTransactionsProvider =
    FutureProvider.family<WalletTransactionsPaginated, WalletTransactionsFilter>(
        (ref, filter) async {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getTransactions(
    type: filter.type,
    referenceType: filter.referenceType,
    fromDate: filter.fromDate,
    toDate: filter.toDate,
    page: filter.page,
    limit: filter.limit,
  );
});

final payoutRequestsProvider =
    FutureProvider.family<PayoutRequestsPaginated, int>((ref, page) async {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getPayoutRequests(page: page);
});

class CreatePayoutRequestNotifier extends AsyncNotifier<PayoutRequest?> {
  @override
  FutureOr<PayoutRequest?> build() {
    return null;
  }

  Future<void> createPayoutRequest(String amount) async {
    state = const AsyncLoading();
    final repository = ref.read(walletRepositoryProvider);
    try {
      final payoutRequest = await repository.createPayoutRequest(amount);
      state = AsyncData(payoutRequest);
      ref.invalidate(walletBalanceProvider);
      ref.invalidate(walletTransactionsProvider);
      ref.invalidate(payoutRequestsProvider);
    } on WalletFailure catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncError(WalletFailure.unknown(e.toString()), stackTrace);
    }
  }
}

final createPayoutRequestProvider =
    AsyncNotifierProvider<CreatePayoutRequestNotifier, PayoutRequest?>(
  CreatePayoutRequestNotifier.new,
);

final vendorDashboardStatsProvider =
    FutureProvider.family<VendorDashboardStats, String>((ref, period) async {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getDashboardStats(period);
});
