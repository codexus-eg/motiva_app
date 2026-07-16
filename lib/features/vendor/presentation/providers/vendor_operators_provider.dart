import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor/data/datasources/vendor_operators_remote_data_source.dart';
import 'package:app/features/vendor/data/repositories/vendor_operators_repository_impl.dart';
import 'package:app/features/vendor/domain/entities/operator.dart';
import 'package:app/features/vendor/domain/repositories/vendor_operators_repository.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorOperatorsRemoteDataSourceProvider =
    Provider<VendorOperatorsRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorOperatorsRemoteDataSourceImpl(dioClient);
    });

final vendorOperatorsRepositoryProvider = Provider<VendorOperatorsRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(vendorOperatorsRemoteDataSourceProvider);
  return VendorOperatorsRepositoryImpl(remoteDataSource);
});

final vendorOperatorsProvider =
    AsyncNotifierProvider<VendorOperatorsNotifier, List<Operator>>(() {
      return VendorOperatorsNotifier();
    });

class VendorOperatorsNotifier extends AsyncNotifier<List<Operator>> {
  @override
  Future<List<Operator>> build() async {
    final vendorProfile = await ref.watch(vendorProfileProvider.future);
    if (vendorProfile == null) {
      return [];
    }
    return _fetchOperators();
  }

  Future<List<Operator>> _fetchOperators() async {
    final repository = ref.read(vendorOperatorsRepositoryProvider);
    return repository.getOperators();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchOperators());
  }

  Future<({bool success, String? errorMessage, String? field})> createOperator(
    CreateOperatorParams params,
  ) async {
    try {
      final repository = ref.read(vendorOperatorsRepositoryProvider);
      final newOperator = await repository.createOperator(params);
      final currentList = state.value ?? [];
      state = AsyncValue.data([...currentList, newOperator]);
      return (success: true, errorMessage: null, field: null);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to create operator',
        error: e,
        stackTrace: stackTrace,
      );
      final errorStr = e.toString().toLowerCase();
      String? field;
      if (errorStr.contains('email') || errorStr.contains('already exists')) {
        if (errorStr.contains('phone') || errorStr.contains('mobile')) {
          field = 'both';
        } else {
          field = 'email';
        }
      } else if (errorStr.contains('phone') || errorStr.contains('mobile')) {
        field = 'phone';
      }
      return (success: false, errorMessage: e.toString(), field: field);
    }
  }

  Future<bool> activateOperator(String operatorId) async {
    try {
      final repository = ref.read(vendorOperatorsRepositoryProvider);
      final updatedOperator = await repository.activateOperator(operatorId);
      final currentList = state.value ?? [];
      state = AsyncValue.data(
        currentList
            .map((op) => op.id == operatorId ? updatedOperator : op)
            .toList(),
      );
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to activate operator',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> deactivateOperator(String operatorId) async {
    try {
      final repository = ref.read(vendorOperatorsRepositoryProvider);
      final updatedOperator = await repository.deactivateOperator(operatorId);
      final currentList = state.value ?? [];
      state = AsyncValue.data(
        currentList
            .map((op) => op.id == operatorId ? updatedOperator : op)
            .toList(),
      );
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to deactivate operator',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> deleteOperator(String operatorId) async {
    try {
      final repository = ref.read(vendorOperatorsRepositoryProvider);
      await repository.deleteOperator(operatorId);
      final currentList = state.value ?? [];
      state = AsyncValue.data(
        currentList.where((op) => op.id != operatorId).toList(),
      );
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to delete operator',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
