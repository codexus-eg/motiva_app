import '../entities/payout_request.dart';
import '../entities/payout_requests_paginated.dart';
import '../entities/vendor_dashboard_stats.dart';
import '../entities/wallet_balance.dart';
import '../entities/wallet_transactions_paginated.dart';

abstract class WalletRepository {
  Future<WalletBalance> getBalance();

  Future<WalletTransactionsPaginated> getTransactions({
    String? type,
    String? referenceType,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int limit = 20,
  });

  Future<PayoutRequest> createPayoutRequest(String amount);

  Future<PayoutRequestsPaginated> getPayoutRequests({
    int page = 1,
    int limit = 20,
  });

  Future<VendorDashboardStats> getDashboardStats(String period);
}
