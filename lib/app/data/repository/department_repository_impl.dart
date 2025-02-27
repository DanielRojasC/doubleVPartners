import 'dart:convert';
import 'dart:io';

import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/repository/department_repository.dart';
import 'package:double_v_partners/app/utils/environment.dart';
import 'package:http/http.dart' as http;

final class DepartmentRepositoryImpl implements DepartmentRepository {
  final httpClient = http.Client();
  final url = "${Environment.departmentsUrl}/department";

  @override
  Future<List<DepartmentEntity>> fetchDepartments() async {
    final response = await httpClient.get(Uri.parse(url)).timeout(
          Duration(
            seconds: 30,
          ),
        );

    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      final departmentsList =
          DepartmentEntity.fromJsonList(jsonDecode(response.body));

      return departmentsList;
    }

    throw Exception();
  }
}
