// To parse this JSON data, do
//
//     final games = gamesFromJson(jsonString);

import 'dart:convert';

List<Games> gamesFromJson(String str) => List<Games>.from(json.decode(str).map((x) => Games.fromJson(x)));

String gamesToJson(List<Games> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Games {
    int? id;
    String? title;
    Type? type;
    double? price;
    String? detail;
    String? picture;

    Games({
        this.id,
        this.title,
        this.type,
        this.price,
        this.detail,
        this.picture,
    });

    factory Games.fromJson(Map<String, dynamic> json) => Games(
        id: json["id"],
        title: json["title"],
        type: typeValues.map[json["type"]]!,
        price: json["price"]?.toDouble(),
        detail: json["detail"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": typeValues.reverse[type],
        "price": price,
        "detail": detail,
        "picture": picture,
    };
}

enum Type {
    ADVENTURE,
    SIMULATION,
    SPORTS
}

final typeValues = EnumValues({
    "Adventure": Type.ADVENTURE,
    "Simulation": Type.SIMULATION,
    "Sports": Type.SPORTS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
