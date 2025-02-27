final class MunicipalityEntity {
  final int municipalityId;
  final int departmentId;
  final String name;

  @override
  int get hashCode => municipalityId.hashCode;

  MunicipalityEntity({
    required this.municipalityId,
    required this.departmentId,
    required this.name,
  });

  factory MunicipalityEntity.fromJson(Map<String, dynamic> json) {
    return MunicipalityEntity(
      municipalityId: json['municipalityId'] ?? json['id'],
      departmentId: json['departmentId'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MunicipalityEntity && other.municipalityId == municipalityId);

  static List<MunicipalityEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MunicipalityEntity.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "municipalityId": municipalityId,
      "departmentId": departmentId,
      "name": name,
    };
  }
}
