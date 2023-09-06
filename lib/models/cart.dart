// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  String? stitle;
  String? stype;
  double? sprice;
  String? srelease;
  String? spicture;
  int? total;
  int? id;

  Cart({
    this.stitle,
    this.stype,
    this.sprice,
    this.srelease,
    this.spicture,
    this.total,
    this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        stitle: json["stitle"],
        stype: json["stype"],
        sprice: json["sprice"]?.toDouble(),
        srelease: json["srelease"],
        spicture: json["spicture"],
        total: json["total"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "stitle": stitle,
        "stype": stype,
        "sprice": sprice,
        "srelease": srelease,
        "spicture": spicture,
        "total": total,
        "id": id,
      };
}
