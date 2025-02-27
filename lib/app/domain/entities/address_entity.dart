import 'dart:convert';

import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';

final class AddressEntity {
  final String addressId;
  final String address;
  final MunicipalityEntity municipality;
  final String zipCode;

  AddressEntity({
    required this.addressId,
    required this.address,
    required this.municipality,
    required this.zipCode,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      addressId: json["addressId"],
      address: json["address"] ?? "",
      municipality: MunicipalityEntity.fromJson(json["municipality"]),
      zipCode: json["zipCode"] ?? "",
    );
  }

  // Function to generate an 8-character unique ID

  Map<String, dynamic> toJson() {
    return {
      "addressId": addressId,
      "address": address,
      "municipality": municipality.toJson(),
      "zipCode": zipCode,
    };
  }

  static List<AddressEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => AddressEntity.fromJson(jsonDecode(json)))
        .toList();
  }
}
