import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/repository/address_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class DeleteAddressUsecase implements UseCase<bool, AddressEntity> {
  final AddressRepository addressRepository;

  DeleteAddressUsecase({required this.addressRepository});
  @override
  Future<bool> call(AddressEntity params) async =>
      await addressRepository.deleteAddress(params);
}
