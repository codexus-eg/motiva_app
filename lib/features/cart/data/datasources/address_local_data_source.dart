import 'dart:convert';

import 'package:app/features/cart/data/models/delivery_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AddressLocalDataSource {
  Future<List<DeliveryAddressModel>> getSavedAddresses();
  Future<void> saveAddress(DeliveryAddressModel address);
  Future<void> deleteAddress(String id);
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  static const _key = 'saved_addresses';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  @override
  Future<List<DeliveryAddressModel>> getSavedAddresses() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_key);
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded
          .map((e) => DeliveryAddressModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveAddress(DeliveryAddressModel address) async {
    final prefs = await _prefs;
    final addresses = await getSavedAddresses();
    final index = addresses.indexWhere((a) => a.id == address.id);

    if (index >= 0) {
      addresses[index] = address;
    } else {
      addresses.add(address);
    }

    final encoded = jsonEncode(addresses.map((a) => a.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  @override
  Future<void> deleteAddress(String id) async {
    final prefs = await _prefs;
    final addresses = await getSavedAddresses();
    addresses.removeWhere((a) => a.id == id);

    final encoded = jsonEncode(addresses.map((a) => a.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
