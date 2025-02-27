import 'package:double_v_partners/app/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<List<AddressEntity>> saveAddress(AddressEntity address);
  Future<List<AddressEntity>> fetchAddresses();
  Future<bool> deleteAddress(AddressEntity address);
}
