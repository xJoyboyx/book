class UserModel {
  final String id;
  final String? email;
  final String externalId;
  final String serviceType;
  final bool? enabled;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserModel({
    required this.id,
    this.email,
    required this.externalId,
    required this.serviceType,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      externalId: json['external_id'],
      serviceType: json['service_type'],
      enabled: json['enabled'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'external_id': externalId,
      'service_type': serviceType,
      'enabled': enabled,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
