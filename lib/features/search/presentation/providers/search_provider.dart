import 'dart:async';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/search/data/datasources/search_remote_data_source.dart';
import 'package:app/features/search/data/repositories/search_repository_impl.dart';
import 'package:app/features/search/domain/entities/search_result.dart';
import 'package:app/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRemoteDataSourceProvider = Provider<SearchRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SearchRemoteDataSourceImpl(dioClient);
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final remoteDS = ref.watch(searchRemoteDataSourceProvider);
  return SearchRepositoryImpl(remoteDS);
});

class SearchNotifier extends AsyncNotifier<List<SearchResult>> {
  Timer? _debounceTimer;

  @override
  Future<List<SearchResult>> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return const [];
  }

  void search(String query) {
    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () async {
      state = await AsyncValue.guard(() async {
        final repo = ref.read(searchRepositoryProvider);
        return await repo.search(query.trim());
      });
    });
  }

  void clear() {
    _debounceTimer?.cancel();
    state = const AsyncValue.data([]);
  }
}

final searchNotifierProvider = AsyncNotifierProvider<SearchNotifier, List<SearchResult>>(
  SearchNotifier.new,
);
