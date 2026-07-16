import 'dart:async';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/search/data/models/search_result_parser.dart';
import 'package:app/features/search/domain/entities/search_result.dart';
import 'package:dio/dio.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResult>> search(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final DioClient _dioClient;

  SearchRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<SearchResult>> search(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/public/search',
        queryParameters: {'q': query},
      );
      final data = response.data as Map<String, dynamic>;
      final resultsJson = data['results'] as List<dynamic>? ?? [];
      return SearchResultParser.fromJsonList(resultsJson);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('search failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final message = DioErrorHandler.handle(e).message;
    return Exception(message);
  }
}
