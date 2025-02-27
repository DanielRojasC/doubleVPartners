import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class DeleteUserUsecase implements UseCase<bool, void> {
  final UserRepository userRepository;

  DeleteUserUsecase({required this.userRepository});
  @override
  Future<bool> call(void params) async => await userRepository.deleteUser();
}
