part of 'department_bloc.dart';

@immutable
sealed class DepartmentState {}

final class DepartmentInitialState extends DepartmentState {}

final class DepartmentLoadingState extends DepartmentState {}

final class DepartmentsFetchedState extends DepartmentState {
  final List<DepartmentEntity> departments;

  DepartmentsFetchedState({required this.departments});
}

final class DepartmentsErrorState extends DepartmentState {}
