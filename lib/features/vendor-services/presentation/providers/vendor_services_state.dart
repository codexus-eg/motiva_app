import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';

class VendorServicesState {
  final List<VendorService> services;
  final Map<String, List<VendorService>> groupedServices;
  final bool isLoading;
  final String? errorMessage;

  const VendorServicesState({
    required this.services,
    required this.groupedServices,
    this.isLoading = false,
    this.errorMessage,
  });

  VendorServicesState copyWith({
    List<VendorService>? services,
    Map<String, List<VendorService>>? groupedServices,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VendorServicesState(
      services: services ?? this.services,
      groupedServices: groupedServices ?? this.groupedServices,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  int get activeServicesCount => services.where((s) => !s.isArchived).length;
  int get archivedServicesCount => services.where((s) => s.isArchived).length;

  List<VendorService> get activeServices =>
      services.where((s) => !s.isArchived).toList();
  List<VendorService> get archivedServices =>
      services.where((s) => s.isArchived).toList();
}
