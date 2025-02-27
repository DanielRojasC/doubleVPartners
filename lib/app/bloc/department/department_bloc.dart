import 'package:bloc/bloc.dart';
import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/repository/department_repository.dart';
import 'package:double_v_partners/app/domain/usecase/department/fetch_departments_usecase.dart';
import 'package:meta/meta.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final DepartmentRepository departmentRepository;
  DepartmentBloc({required this.departmentRepository})
      : super(DepartmentInitialState()) {
    on<FetchDepartmentsEvent>((_, emit) async => await _fetchDepartments(emit));
    on<DepartmentInitialEvent>((_, emit) => emit(DepartmentInitialState()));
  }

  Future<void> _fetchDepartments(Emitter<DepartmentState> emit) async {
    emit(DepartmentLoadingState());

    try {
      final usecase =
          FetchDepartmentsUsecase(departmentRepository: departmentRepository);

      final departmentsResponse = await usecase.call(null);

      emit(DepartmentsFetchedState(departments: departmentsResponse));
    } catch (e) {
      emit(DepartmentsErrorState());
    }
  }
}
