import 'package:double_v_partners/app/domain/entities/department_entity.dart';

abstract class DepartmentRepository {
  Future<List<DepartmentEntity>> fetchDepartments();
}
