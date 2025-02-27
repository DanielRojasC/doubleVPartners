part of 'department_bloc.dart';

@immutable
sealed class DepartmentEvent {}

final class DepartmentInitialEvent extends DepartmentEvent {}

final class FetchDepartmentsEvent extends DepartmentEvent {}
