part of 'municipality_bloc.dart';

@immutable
sealed class MunicipalityEvent {}

final class MunicipalityInitialEvent extends MunicipalityEvent {}

final class FetchMunicipalityEvent extends MunicipalityEvent {
  final int departmentId;
  FetchMunicipalityEvent({required this.departmentId});
}
