import 'dart:convert';

import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/repository/address_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<List<AddressEntity>> saveAddress(AddressEntity address) async {
    final prefs = await initPrefs();
    try {
      List<String> addresses = await prefs.getStringList("addresses") ?? [];

      int indexUpdate = addresses.indexWhere((addressPrefs) {
        final Map<String, dynamic> decodedAddress = jsonDecode(addressPrefs);

        return decodedAddress["addressId"] == address.addressId;
      });

      if (indexUpdate == -1) {
        addresses.add(jsonEncode(address.toJson()));
        Future.value(await prefs.setStringList("addresses", addresses));
      } else {
        addresses[indexUpdate] = jsonEncode(address.toJson());
        Future.value(await prefs.setStringList("addresses", addresses));
      }

      return AddressEntity.fromJsonList(addresses);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<AddressEntity>> fetchAddresses() async {
    final prefs = await initPrefs();

    try {
      List<String> addresses = await prefs.getStringList("addresses") ?? [];

      return AddressEntity.fromJsonList(addresses);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> deleteAddress(AddressEntity address) async {
    final prefs = await initPrefs();

    try {
      List<String> addresses = await prefs.getStringList("addresses") ?? [];

      addresses.removeWhere(
        (addressPrefs) =>
            addressPrefs ==
            jsonEncode(
              address.toJson(),
            ),
      );

      Future.value(await prefs.remove("addresses"));

      Future.value(await prefs.setStringList("addresses", addresses));

      return true;
    } catch (e) {
      throw Exception();
    }
  }

  Future<SharedPreferences> initPrefs() async =>
      await SharedPreferences.getInstance();
}
