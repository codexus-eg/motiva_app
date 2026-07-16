import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';

class VendorProductsState {
  final List<VendorProduct> products;
  final bool isLoading;
  final String? errorMessage;

  const VendorProductsState({
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  VendorProductsState copyWith({
    List<VendorProduct>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VendorProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  int get activeProductsCount => products.where((p) => p.isActive).length;
  int get inactiveProductsCount => products.where((p) => !p.isActive).length;

  List<VendorProduct> get activeProducts =>
      products.where((p) => p.isActive).toList();
  List<VendorProduct> get inactiveProducts =>
      products.where((p) => !p.isActive).toList();
}
