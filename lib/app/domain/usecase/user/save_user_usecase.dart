import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class SaveUserUsecase implements UseCase<bool, UserEntity> {
  final UserRepository userRepository;
  SaveUserUsecase({required this.userRepository});
  @override
  Future<bool> call(UserEntity params) async =>
      await userRepository.saveUser(params);
}
