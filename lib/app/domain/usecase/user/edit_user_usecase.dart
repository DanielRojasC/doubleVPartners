import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class EditUserUsecase implements UseCase<UserEntity, UserEntity> {
  final UserRepository userRepository;
  EditUserUsecase({required this.userRepository});
  @override
  Future<UserEntity> call(UserEntity params) async =>
      await userRepository.editUser(params);
}
