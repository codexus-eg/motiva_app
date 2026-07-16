import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/loyalty/data/datasources/loyalty_remote_data_source.dart';
import 'package:app/features/loyalty/domain/entities/loyalty_config.dart';
import 'package:app/features/loyalty/domain/entities/loyalty_transaction.dart';
import 'package:app/features/loyalty/domain/failures/loyalty_failure.dart';
import 'package:app/features/loyalty/domain/repositories/loyalty_repository.dart';

class LoyaltyRepositoryImpl implements LoyaltyRepository {
  final LoyaltyRemoteDataSource _remoteDataSource;

  LoyaltyRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<LoyaltyTransaction>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final models = await _remoteDataSource.getTransactions(
        type: type,
        page: page,
        limit: limit,
      );
      return models.map((m) => m.transaction).toList();
    } catch (e, stackTrace) {
      if (e is LoyaltyFailure) rethrow;
      AppLogger.error('getTransactions failed', error: e, stackTrace: stackTrace);
      throw LoyaltyFailure.unknown(e.toString());
    }
  }

  @override
  Future<LoyaltyConfig> getLoyaltyConfig() async {
    try {
      final model = await _remoteDataSource.getLoyaltyConfig();
      return model.config;
    } catch (e, stackTrace) {
      if (e is LoyaltyFailure) rethrow;
      AppLogger.error('getLoyaltyConfig failed', error: e, stackTrace: stackTrace);
      throw LoyaltyFailure.unknown(e.toString());
    }
  }
}
