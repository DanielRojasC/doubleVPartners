import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';
import 'package:double_v_partners/app/domain/repository/municipality_repository.dart';
import 'package:double_v_partners/app/domain/usecase/usecase.dart';

final class FetchMunicipalitiesUseCase
    implements UseCase<List<MunicipalityEntity>, int> {
  final MunicipalityRepository municipalityRepository;

  FetchMunicipalitiesUseCase({required this.municipalityRepository});

  @override
  Future<List<MunicipalityEntity>> call(int params) async {
    final municipalities =
        await municipalityRepository.fetchMunicipalities(params);
    sortMunicipalitiesAlphabetically(municipalities);

    return municipalities;
  }

  void sortMunicipalitiesAlphabetically(
    List<MunicipalityEntity> departments,
  ) =>
      departments.sort((a, b) => a.name.compareTo(b.name));
}
