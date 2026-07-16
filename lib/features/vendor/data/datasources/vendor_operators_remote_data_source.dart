import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor/data/models/operator_model.dart';
import 'package:app/features/vendor/domain/entities/operator.dart';

abstract class VendorOperatorsRemoteDataSource {
  Future<List<Operator>> getOperators();
  Future<Operator> createOperator(CreateOperatorParams params);
  Future<Operator> activateOperator(String operatorId);
  Future<Operator> deactivateOperator(String operatorId);
  Future<void> deleteOperator(String operatorId);
}

class VendorOperatorsRemoteDataSourceImpl
    implements VendorOperatorsRemoteDataSource {
  final DioClient _dioClient;

  VendorOperatorsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<Operator>> getOperators() async {
    final response = await _dioClient.dio.get('/api/vendors/operators');
    final data = response.data;

    AppLogger.info('getOperators response: $data');

    if (data is Map<String, dynamic> && data['operators'] is List) {
      final operatorsList = data['operators'] as List;
      AppLogger.info('Found ${operatorsList.length} operators in response');
      return operatorsList
          .map(
            (json) =>
                OperatorModel.fromJson(json as Map<String, dynamic>).operator,
          )
          .toList();
    }

    if (data is List) {
      AppLogger.info('Response is direct list with ${data.length} operators');
      return data
          .map(
            (json) =>
                OperatorModel.fromJson(json as Map<String, dynamic>).operator,
          )
          .toList();
    }

    AppLogger.warning('Unexpected response format in getOperators: $data');
    return [];
  }

  @override
  Future<Operator> createOperator(CreateOperatorParams params) async {
    final response = await _dioClient.dio.post(
      '/api/vendors/operators',
      data: params.toJson(),
    );
    final operatorJson = response.data as Map<String, dynamic>;
    return OperatorModel.fromJson(operatorJson).operator;
  }

  @override
  Future<Operator> activateOperator(String operatorId) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/operators/$operatorId/activate',
    );
    final operatorJson = response.data as Map<String, dynamic>;
    return OperatorModel.fromJson(operatorJson).operator;
  }

  @override
  Future<Operator> deactivateOperator(String operatorId) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/operators/$operatorId/deactivate',
    );
    final operatorJson = response.data as Map<String, dynamic>;
    return OperatorModel.fromJson(operatorJson).operator;
  }

  @override
  Future<void> deleteOperator(String operatorId) async {
    await _dioClient.dio.delete('/api/vendors/operators/$operatorId');
  }
}
