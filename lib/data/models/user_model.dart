import 'dart:convert';

class UserModel {
  String id;
  String? email;
  String? externalId;
  String? serviceType;
  bool? enabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserModel({
    required this.id,
    this.email,
    this.externalId,
    this.serviceType,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        email: json["email"],
        externalId: json["external_id"],
        serviceType: json["service_type"],
        enabled: json["enabled"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "external_id": externalId,
        "service_type": serviceType,
        "enabled": enabled,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
