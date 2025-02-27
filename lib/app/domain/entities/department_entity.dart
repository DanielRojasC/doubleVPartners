final class DepartmentEntity {
  final int departmentId;
  final String name;

  DepartmentEntity({required this.departmentId, required this.name});

  factory DepartmentEntity.fromJson(Map<String, dynamic> json) {
    return DepartmentEntity(
      departmentId: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  static List<DepartmentEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DepartmentEntity.fromJson(json)).toList();
  }
}
