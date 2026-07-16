import '../entities/cart.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<Cart> addItem({required String productId, required int quantity});
  Future<Cart> updateItem({required String itemId, required int quantity});
  Future<Cart> removeItem({required String itemId});
  Future<Cart> clearCart();
}
