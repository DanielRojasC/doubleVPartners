import 'dart:convert';

import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class UserRepositoryImpl implements UserRepository {
  @override
  Future<dynamic> fetchUser() async {
    final prefs = await initPrefs();
    try {
      final user = await prefs.getString("user");

      return user != null ? UserEntity.fromJson(jsonDecode(user)) : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> saveUser(UserEntity user) async {
    final prefs = await initPrefs();
    try {
      Future.value(await prefs.setString("user", jsonEncode(user.toJson())));

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteUser() async {
    final prefs = await initPrefs();
    try {
      Future.value(prefs.remove("addresses"));
      Future.value(prefs.remove("user"));

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserEntity> editUser(UserEntity user) async {
    final prefs = await initPrefs();
    try {
      Future.value(prefs.remove("user"));
      Future.value(await prefs.setString("user", jsonEncode(user.toJson())));

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SharedPreferences> initPrefs() async =>
      await SharedPreferences.getInstance();
}
