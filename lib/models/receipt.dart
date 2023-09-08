// To parse this JSON data, do
//
//     final receipt = receiptFromJson(jsonString);

import 'dart:convert';

List<Map<String, dynamic>> receiptFromJson(String str) => List<Map<String, dynamic>>.from(json.decode(str).map((x) => Receipt.fromJson(x)));

String receiptToJson(List<Receipt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Receipt {
    DateTime? time;
    int? receiptUserId;
    List<Game>? game;
    double? total;

    Receipt({
        this.time,
        this.receiptUserId,
        this.game,
        this.total,
    });

    factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        time: json["Time"] == null ? null : DateTime.parse(json["Time"]),
        receiptUserId: json["userId"],
        game: json["game"] == null ? [] : List<Game>.from(json["game"]!.map((x) => Game.fromJson(x))),
        total: json["total"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Time": time?.toIso8601String(),
        "userId": receiptUserId,
        "game": game == null ? [] : List<dynamic>.from(game!.map((x) => x.toJson())),
        "total": total,
    };
}

class Game {
    String? title;
    String? type;
    String? release;
    double? price;
    int? total;

    Game({
        this.title,
        this.type,
        this.release,
        this.price,
        this.total,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        title: json["title"],
        type: json["type"],
        release: json["release"],
        price: json["price"]?.toDouble(),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "release": release,
        "price": price,
        "total": total,
    };
}
