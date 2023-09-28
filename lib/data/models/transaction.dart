import 'dart:convert';

class Transaction {
  String? id;
  String? userId;
  DateTime? date;
  double? amount;
  String? currency;
  String? description;
  String? type;
  String? productId;
  String? platform;
  int? v;

  Transaction({
    this.id,
    this.userId,
    this.date,
    this.amount,
    this.currency,
    this.description,
    this.type,
    this.productId,
    this.platform,
    this.v,
  });

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        userId: json["userId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        amount: json["amount"]?.toDouble(),
        currency: json["currency"],
        description: json["description"],
        type: json["type"],
        productId: json["productId"],
        platform: json["platform"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "date": date?.toIso8601String(),
        "amount": amount,
        "currency": currency,
        "description": description,
        "type": type,
        "productId": productId,
        "platform": platform,
        "__v": v,
      };
}
