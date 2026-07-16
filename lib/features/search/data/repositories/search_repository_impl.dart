import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/search/data/datasources/search_remote_data_source.dart';
import 'package:app/features/search/domain/entities/search_result.dart';
import 'package:app/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<SearchResult>> search(String query) async {
    try {
      return await _remoteDataSource.search(query);
    } catch (e, stackTrace) {
      AppLogger.error('search repository failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
