import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/loyalty/data/datasources/loyalty_remote_data_source.dart';
import 'package:app/features/loyalty/data/repositories/loyalty_repository_impl.dart';
import 'package:app/features/loyalty/domain/entities/loyalty_config.dart';
import 'package:app/features/loyalty/domain/entities/loyalty_transaction.dart';
import 'package:app/features/loyalty/domain/repositories/loyalty_repository.dart';

final loyaltyRemoteDataSourceProvider = Provider<LoyaltyRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return LoyaltyRemoteDataSourceImpl(dioClient);
});

final loyaltyRepositoryProvider = Provider<LoyaltyRepository>((ref) {
  final remoteDataSource = ref.watch(loyaltyRemoteDataSourceProvider);
  return LoyaltyRepositoryImpl(remoteDataSource);
});

final loyaltyTransactionsProvider =
    FutureProvider.family<List<LoyaltyTransaction>, String?>((ref, type) async {
      final repository = ref.watch(loyaltyRepositoryProvider);
      return await repository.getTransactions(type: type);
    });

final loyaltyConfigProvider = FutureProvider<LoyaltyConfig>((ref) async {
  final repository = ref.watch(loyaltyRepositoryProvider);
  return await repository.getLoyaltyConfig();
});
