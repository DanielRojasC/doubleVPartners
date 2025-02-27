import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class FetchUserUsecase implements UseCase<dynamic, void> {
  final UserRepository userRepository;

  FetchUserUsecase({required this.userRepository});
  @override
  Future call(void params) async => await userRepository.fetchUser();
}
