part of 'municipality_bloc.dart';

@immutable
sealed class MunicipalityState {}

final class MunicipalityInitialState extends MunicipalityState {}

final class MunicipalityLoadingState extends MunicipalityState {}

final class MunicipalityFetchedState extends MunicipalityState {
  final List<MunicipalityEntity> municipalities;

  MunicipalityFetchedState({required this.municipalities});
}

final class MunicipalityErrorState extends MunicipalityState {}
