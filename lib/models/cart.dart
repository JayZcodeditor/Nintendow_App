import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  int? id;
  int? userId; // Add userId field
  int? gameId;
  String? gameTitle;
  double? gamePrice; // Change gamePrice to double
  String? gamePicture;
  int? total;

  Cart({
    this.id,
    this.userId, // Include userId in the constructor
    this.gameId,
    this.gameTitle,
    this.gamePrice, // Change gamePrice to double
    this.gamePicture,
    this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"], // Deserialize userId from JSON
        gameId: json["Game_id"],
        gameTitle: json["Game_title"],
        gamePrice: json["Game_price"]?.toDouble(), // Deserialize gamePrice as double
        gamePicture: json["Game_picture"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId, // Serialize userId to JSON
        "Game_id": gameId,
        "Game_title": gameTitle,
        "Game_price": gamePrice, // Serialize gamePrice as double
        "Game_picture": gamePicture,
        "total": total,
      };
}
