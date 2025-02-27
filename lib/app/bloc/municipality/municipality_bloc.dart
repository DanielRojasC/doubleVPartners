import 'package:bloc/bloc.dart';
import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';
import 'package:double_v_partners/app/domain/repository/municipality_repository.dart';
import 'package:double_v_partners/app/domain/usecase/municipality/fetch_departments_usecase.dart';
import 'package:meta/meta.dart';

part 'municipality_event.dart';
part 'municipality_state.dart';

class MunicipalityBloc extends Bloc<MunicipalityEvent, MunicipalityState> {
  MunicipalityRepository municipalityRepository;
  MunicipalityBloc({required this.municipalityRepository})
      : super(MunicipalityInitialState()) {
    on<FetchMunicipalityEvent>(
      (event, emit) async => await _fetchMunicipalities(event, emit),
    );
    on<MunicipalityInitialEvent>((_, emit) => emit(MunicipalityInitialState()));
  }

  Future<void> _fetchMunicipalities(
    FetchMunicipalityEvent event,
    Emitter<MunicipalityState> emit,
  ) async {
    emit(MunicipalityLoadingState());

    try {
      emit(MunicipalityLoadingState());

      final usecase = FetchMunicipalitiesUseCase(
        municipalityRepository: municipalityRepository,
      );

      final municipalities = await usecase.call(event.departmentId);

      emit(MunicipalityFetchedState(municipalities: municipalities));
    } catch (e) {
      emit(MunicipalityErrorState());
    }
  }
}
