import '../entities/loyalty_config.dart';
import '../entities/loyalty_transaction.dart';

abstract class LoyaltyRepository {
  Future<List<LoyaltyTransaction>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  });

  Future<LoyaltyConfig> getLoyaltyConfig();
}
