import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/data/datasources/voucher_remote_data_source.dart';
import 'package:app/features/cart/domain/entities/voucher_response.dart';
import 'package:app/features/cart/domain/failures/voucher_failure.dart';
import 'package:app/features/cart/domain/repositories/voucher_repository.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherRemoteDataSource _remoteDataSource;

  VoucherRepositoryImpl(this._remoteDataSource);

  @override
  Future<VoucherResponse> redeem(String code) async {
    try {
      return await _remoteDataSource.redeem(code);
    } catch (e, stackTrace) {
      if (e is VoucherFailure) rethrow;
      AppLogger.error('voucher redeem failed', error: e, stackTrace: stackTrace);
      throw VoucherFailure.unknown(e.toString());
    }
  }
}
