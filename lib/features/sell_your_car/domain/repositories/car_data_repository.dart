import 'package:app/features/sell_your_car/domain/entities/entities.dart';

abstract class CarDataRepository {
  Future<List<CarMake>> getMakes();
  Future<List<CarMake>> searchMakes(String query);
  Future<List<CarModel>> getModelsByMake(String makeId);
  Future<List<CarTrim>> getTrimsByModel(String modelId);
  Future<List<int>> getYearsForModel(String modelId);
}
