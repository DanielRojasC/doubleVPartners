import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';

abstract class MunicipalityRepository {
  Future<List<MunicipalityEntity>> fetchMunicipalities(int departmentId);
}
