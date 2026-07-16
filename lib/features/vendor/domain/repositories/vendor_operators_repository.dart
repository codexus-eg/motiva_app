import 'package:app/features/vendor/domain/entities/operator.dart';

abstract class VendorOperatorsRepository {
  Future<List<Operator>> getOperators();
  Future<Operator> createOperator(CreateOperatorParams params);
  Future<Operator> activateOperator(String operatorId);
  Future<Operator> deactivateOperator(String operatorId);
  Future<void> deleteOperator(String operatorId);
}
