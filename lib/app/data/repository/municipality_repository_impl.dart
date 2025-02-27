import 'dart:convert';
import 'dart:io';

import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';
import 'package:double_v_partners/app/domain/repository/municipality_repository.dart';
import 'package:double_v_partners/app/utils/environment.dart';

import 'package:http/http.dart' as http;

final class MunicipalityRepositoryImpl implements MunicipalityRepository {
  final httpClient = http.Client();
  final url = "${Environment.departmentsUrl}/department";
  @override
  Future<List<MunicipalityEntity>> fetchMunicipalities(int departmentId) async {
    final response =
        await httpClient.get(Uri.parse("${url}/$departmentId/cities")).timeout(
              Duration(
                seconds: 30,
              ),
            );

    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      final municipalitiesList =
          MunicipalityEntity.fromJsonList(jsonDecode(response.body));

      return municipalitiesList;
    }

    throw Exception();
  }
}
