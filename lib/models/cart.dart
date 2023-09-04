// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  int? id;
  String? stitle;
  String? sprice;
  String? spicture;
  String? srelease;
  String? stype;
  int? total;

  Cart({
    this.id,
    this.stitle,
    this.sprice,
    this.spicture,
    this.srelease,
    this.stype,
    this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        stitle: json["stitle"],
        sprice: json["sprice"],
        spicture: json["spicture"],
        srelease: json["srelease"],
        stype: json["stype"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stitle": stitle,
        "sprice": sprice,
        "spicture": spicture,
        "srelease": srelease,
        "stype": stype,
        "total": total,
      };
}
