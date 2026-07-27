import '../entities/checkout_result.dart';
import '../entities/delivery_address.dart';

abstract class CheckoutRepository {
  Future<CheckoutResult> checkout({
    DeliveryAddress? address,
    String? voucherCode,
  });
}
