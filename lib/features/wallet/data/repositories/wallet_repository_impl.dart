import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:app/features/wallet/data/models/payout_request_model.dart';
import 'package:app/features/wallet/data/models/payout_requests_paginated_model.dart';
import 'package:app/features/wallet/data/models/vendor_dashboard_stats_model.dart';
import 'package:app/features/wallet/data/models/wallet_balance_model.dart';
import 'package:app/features/wallet/data/models/wallet_transactions_paginated_model.dart';
import 'package:app/features/wallet/domain/entities/payout_request.dart';
import 'package:app/features/wallet/domain/entities/payout_requests_paginated.dart';
import 'package:app/features/wallet/domain/entities/vendor_dashboard_stats.dart';
import 'package:app/features/wallet/domain/entities/wallet_balance.dart';
import 'package:app/features/wallet/domain/entities/wallet_transactions_paginated.dart';
import 'package:app/features/wallet/domain/failures/wallet_failure.dart';
import 'package:app/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;

  WalletRepositoryImpl(this._remoteDataSource);

  @override
  Future<WalletBalance> getBalance() async {
    try {
      final response = await _remoteDataSource.getBalance();
      return WalletBalanceModel.fromJson(response).balance;
    } catch (e, stackTrace) {
      if (e is WalletFailure) rethrow;
      AppLogger.error('getBalance failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<WalletTransactionsPaginated> getTransactions({
    String? type,
    String? referenceType,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _remoteDataSource.getTransactions(
        type: type,
        referenceType: referenceType,
        fromDate: fromDate?.toIso8601String(),
        toDate: toDate?.toIso8601String(),
        page: page,
        limit: limit,
      );
      return WalletTransactionsPaginatedModel.fromJson(response).paginated;
    } catch (e, stackTrace) {
      if (e is WalletFailure) rethrow;
      AppLogger.error('getTransactions failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<PayoutRequest> createPayoutRequest(String amount) async {
    try {
      final response = await _remoteDataSource.createPayoutRequest(amount);
      return PayoutRequestModel.fromJson(response).request;
    } catch (e, stackTrace) {
      if (e is WalletFailure) rethrow;
      AppLogger.error('createPayoutRequest failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<PayoutRequestsPaginated> getPayoutRequests({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _remoteDataSource.getPayoutRequests(
        page: page,
        limit: limit,
      );
      return PayoutRequestsPaginatedModel.fromJson(response).paginated;
    } catch (e, stackTrace) {
      if (e is WalletFailure) rethrow;
      AppLogger.error('getPayoutRequests failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorDashboardStats> getDashboardStats(String period) async {
    try {
      final response = await _remoteDataSource.getDashboardStats(period);
      return VendorDashboardStatsModel.fromJson(response).stats;
    } catch (e, stackTrace) {
      if (e is WalletFailure) rethrow;
      AppLogger.error('getDashboardStats failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }
}
