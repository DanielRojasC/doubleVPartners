import 'package:double_v_partners/app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<dynamic> fetchUser();
  Future<bool> saveUser(UserEntity user);
  Future<UserEntity> editUser(UserEntity user);
  Future<bool> deleteUser();
}
