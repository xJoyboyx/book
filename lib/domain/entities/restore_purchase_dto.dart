import 'dart:convert';

class RestorePurchaseDTO {
  String? userId;
  String? productId;

  RestorePurchaseDTO({
    this.userId,
    this.productId,
  });

  factory RestorePurchaseDTO.fromRawJson(String str) =>
      RestorePurchaseDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestorePurchaseDTO.fromJson(Map<String, dynamic> json) =>
      RestorePurchaseDTO(
        userId: json["userId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
      };
}
