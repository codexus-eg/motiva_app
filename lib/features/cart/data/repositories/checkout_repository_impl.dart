import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/data/datasources/checkout_remote_data_source.dart';
import 'package:app/features/cart/data/models/delivery_address_model.dart';
import 'package:app/features/cart/domain/entities/checkout_result.dart';
import 'package:app/features/cart/domain/entities/delivery_address.dart';
import 'package:app/features/cart/domain/failures/checkout_failure.dart';
import 'package:app/features/cart/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  CheckoutRepositoryImpl(this._remoteDataSource);

  @override
  Future<CheckoutResult> checkout({DeliveryAddress? address}) async {
    try {
      final addressModel =
          address != null ? DeliveryAddressModel.fromEntity(address) : null;
      return await _remoteDataSource.checkout(address: addressModel);
    } catch (e, stackTrace) {
      if (e is CheckoutFailure) rethrow;
      AppLogger.error('checkout failed', error: e, stackTrace: stackTrace);
      throw CheckoutFailure.unknown(e.toString());
    }
  }
}
