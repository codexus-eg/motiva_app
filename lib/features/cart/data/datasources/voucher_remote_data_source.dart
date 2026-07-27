import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/domain/entities/voucher_response.dart';
import 'package:app/features/cart/domain/failures/voucher_failure.dart';
import 'package:dio/dio.dart';

abstract class VoucherRemoteDataSource {
  Future<VoucherResponse> redeem(String code);
}

class VoucherRemoteDataSourceImpl implements VoucherRemoteDataSource {
  final DioClient _dioClient;

  VoucherRemoteDataSourceImpl(this._dioClient);

  @override
  Future<VoucherResponse> redeem(String code) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/vouchers/redeem',
        data: {'code': code},
      );

      final voucherData = response.data['voucher'] as Map<String, dynamic>;
      final transactionData =
          response.data['transaction'] as Map<String, dynamic>;

      return VoucherResponse(
        discountAmount: double.parse(voucherData['amount'] as String),
        newTotal: double.parse(transactionData['balanceBefore'] as String),
        message: 'Voucher redeemed successfully',
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'voucher redeem failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  VoucherFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return VoucherFailure.unauthorized();
      case 403:
        return VoucherFailure.forbidden();
      case 400:
        return VoucherFailure.unknown(message);
      case 404:
        return VoucherFailure.notFound();
      case 500:
        return VoucherFailure.unknown(message);
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return VoucherFailure.networkError();
        }
        return VoucherFailure.unknown(message);
    }
  }
}
