import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/repository/department_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class FetchDepartmentsUsecase
    implements UseCase<List<DepartmentEntity>, void> {
  final DepartmentRepository departmentRepository;

  FetchDepartmentsUsecase({required this.departmentRepository});

  @override
  Future<List<DepartmentEntity>> call(void params) async {
    final departments = await departmentRepository.fetchDepartments();
    sortDepartmentsAlphabetically(departments);

    return departments;
  }

  void sortDepartmentsAlphabetically(
    List<DepartmentEntity> departments,
  ) =>
      departments.sort((a, b) => a.name.compareTo(b.name));
}
