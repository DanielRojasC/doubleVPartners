import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/repository/address_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class SaveAddressUsecase
    implements UseCase<List<AddressEntity>, AddressEntity> {
  final AddressRepository addressRepository;

  SaveAddressUsecase({required this.addressRepository});
  @override
  Future<List<AddressEntity>> call(AddressEntity params) async =>
      await addressRepository.saveAddress(params);
}
