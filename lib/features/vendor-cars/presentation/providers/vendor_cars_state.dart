import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';

class VendorCarsState {
  final List<VendorCar> cars;
  final bool isLoading;
  final String? errorMessage;

  const VendorCarsState({
    required this.cars,
    this.isLoading = false,
    this.errorMessage,
  });

  VendorCarsState copyWith({
    List<VendorCar>? cars,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VendorCarsState(
      cars: cars ?? this.cars,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  int get activeCarsCount => cars.where((c) => c.isActive).length;
  int get inactiveCarsCount => cars.where((c) => !c.isActive).length;

  List<VendorCar> get activeCars => cars.where((c) => c.isActive).toList();
  List<VendorCar> get inactiveCars => cars.where((c) => !c.isActive).toList();
}
