import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/repository/address_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class FetchAddressesUsecase implements UseCase<List<AddressEntity>, void> {
  final AddressRepository addressRepository;

  FetchAddressesUsecase({required this.addressRepository});
  @override
  Future<List<AddressEntity>> call(void params) async =>
      await addressRepository.fetchAddresses();
}
