final class UserEntity {
  final String name;
  final String lastName;
  final DateTime birthdate;

  UserEntity({
    required this.name,
    required this.lastName,
    required this.birthdate,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json["name"] ?? "",
      lastName: json["lastName"] ?? "",
      birthdate:
          DateTime.parse(json["birthdate"]), // Convert String to DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "birthdate": birthdate.toIso8601String(), // Convert DateTime to String
    };
  }
}
