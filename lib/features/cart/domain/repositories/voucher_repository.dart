import '../entities/voucher_response.dart';

abstract class VoucherRepository {
  Future<VoucherResponse> redeem(String code);
}
